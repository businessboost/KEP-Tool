function [kep, exports] = opt_imex(MG,ntc,demand,array_parks, array_hydro)
% main_data_open opens all files with the needed data for the kep
% Input: MG (integer): number of markets
%        ntc (MGxMG cell): each cell contains the double value of the ntc
%        demand (MGx1 double), Vektor with the demand of all markets for
%        one timestap
%        array_parks (MG cell): cell array with all normal parks
%        array_hydro (MG cell): cell array with all hydro parks
% Output: kep (PPx1 couble): optimized service of each powerplant 
%       : exports : 
% Algorithm: optimizes the imports and exports for one timestep
% Date: 05.01.2014
% Known bugs: 
% Version: 1.0
% Author: Jan Reiff
% Functions used: nothing special
% Variables: sqrMG : square of MG
%          : all_parks        : all parks together as one park
%          : PP_all           : number of powerplants of all markets
%          : ntc_importvector : maximum of possible import between two
%                               markets. Needed for the lineprog
%          : ntc_exportvector : similar to ntc_importvector, but the
%                               maximum of possible export between two
%                               markets. Also needed for the lineprog
  
 % connect all parks to one variable
 model = Cplex('rolfe');
 model.Model.sense = 'minimize';
 
   all_parks = array_parks{1};
  for mg=2:MG
     all_parks = [all_parks; array_parks{mg}];
  end
  
  PP_all = size(all_parks,1);

 
 
 ctype = '';
 for i = 1:PP_all
    ctype = strcat (ctype, 'S');
 end
 for i = 1 : MG*MG
    ctype = strcat (ctype, 'C');
 end
 
 
kvar_ofvector = all_parks(:,2)';
zero_ofvektor = zeros(1,MG*MG);
f = [kvar_ofvector zero_ofvektor]; % = costs


  
 
  % Constraints
    % lower Bound: minArray
      zero_lbvector = zeros(1,PP_all);
      pmin_lbvector = all_parks(:,3)';
      ntc_importvector = [];
      
      % transform the ntc matrix to a vector with width of MG*MG
      temp = ntc;
      while size(temp,2)>0 % until temp is not empty
         ntc_importvector = [ntc_importvector temp(:,1)']; % add first column transformed to a row with '
         temp = temp(:,2:end); % cut of the added column
      end
      
      lb = [pmin_lbvector -ntc_importvector]; % lower bounds for powerplants is pmin, for the transfers ntc vlaues
     
     % Upper Bound: max Array 
      pmax_ubvektor = all_parks(:,4)';
      ntc_exportvector = [];
      temp = ntc;
      
      % transform the ntc matrix to a vector with width of MG*MG
      while size(temp,1)>0
          ntc_exportvector = [ntc_exportvector temp(1,:)]; % add first row to the exportvector
          temp = temp(2:end,:); % cut of added row
      end
      ub = [pmax_ubvektor ntc_exportvector];
      model.addCols(f', [], lb', ub', ctype);

     % Lastdeckungsbedingung
      lhs = demand; % left hand side
      rhs = ones(MG,1)*inf;
      pp_matrix = zeros(MG,PP_all);
      export_matrix = zeros(MG,MG*MG);
      pp_index_relativ = 0;
      for mg=1:MG
          pp = size(array_parks{mg},1);
          pp_matrix(mg,pp_index_relativ+1:pp_index_relativ+pp) = ones(1,pp);
          export_matrix(mg,MG*(mg-1)+1:MG*mg) = ones(1,MG);
          pp_index_relativ = pp_index_relativ + pp;
      end
      A = [pp_matrix -export_matrix];
      model.addRows(lhs, A, rhs);
      
% antisymmetry: MG*MG constraints 
  Aeq = zeros(MG*MG,MG*MG);
  beq = zeros(MG*MG,1);
  index_constraint = 0;
  for i = 1: MG
     for j = 1 : MG
         index_constraint = index_constraint + 1;
         Aeq(index_constraint,((i-1)*MG)+j) = 1;
         Aeq(index_constraint,((j-1)*MG)+i) = 1;
     end
  end
  zero_matrix = zeros(MG*MG,PP_all);
  Aeq = [zero_matrix Aeq];
  model.addRows(beq, Aeq, beq);
  model.solve();
  x = model.Solution.x;


  
  
  for mg = 1 : MG
      pp = size(array_parks{mg},1);
      kep{mg}(1:pp,1) = x(1:pp,1);
      x = x(pp+1:end,1);
  end 
  kep = kep';

  exports = zeros(MG,MG);
  for mg = 1 : MG
       exports(mg,:) = x(1:MG,1);
       x = x(MG+1:end,1);

  end
end