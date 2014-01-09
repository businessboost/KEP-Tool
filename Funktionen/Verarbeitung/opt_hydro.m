 % Erstelle Energiespeicher [E1, ET, Emax, Pmin, Pmax, eta]
 function hydro_kep = opt_hydro(mp,eta,Pmin,Pmax,Emax, e1, eT)
  % main_data_open opens all files with the needed data for the kep
  % Input: mp (1xT double) : market price  
  %      : Pmin (double) : minimum service (negative) ->|Pmin|: maximum load
  %                                                      performance
  %      : Pmax (double) : maximum service 
  %      : Emax (double) : maximum capacity
  %      : E1 (double) : load in beginning
  %      : ET (double) : load in the end
  % Output: hydro_kep (1xT double) : service of hydraulic power plant
  % Algorithm:
  % Date:
  % Version:
  % Known bugs: 
  % Version:
  % Author:
  % Functions used : open_powerplant_park()
  %                : open_ntc_matrix()
  %                : open_demand()
  % Variables:
T = size(mp,2);
costs = mp./eta;

nix = zeros(1,T);
pmax = Pmax*ones(1,T);
pmin = Pmin*ones(1,T);
emax = Emax*ones(1,T);
f = [-mp costs nix 0];
lb = [nix nix nix 0];
ub = [pmax -pmin emax Emax];

Aeq = [];
for i = 1 : T
  line = [vec(T,[i],[]),vec(T,[],[i]),vec(T+1,[i+1],[i])];
  Aeq = [Aeq;line];
end
Aeq = [Aeq;zeros(1,T),zeros(1,T),vec(T+1,1,[]);zeros(1,T),zeros(1,T),vec(T+1,T+1,[])];
beq = [zeros(T,1) ;e1 ;eT];
% Aeq = ...
% [ 1 0 0 0 0 0  -1 0 0 0 0 0  -1 +1 0 0 0 0;...
%   0 1 0 0 0 0  0 -1 0 0 0 0   0 -1 +1 0 0 0;...
%   0 0 1 0 0 0  0 0 -1 0 0 0   0 0 -1 +1 0 0;...
%   0 0 0 1 0 0  0 0 0 -1 0 0   0 0 0 -1 +1 0;...
%   0 0 0 0 1 0  0 0 0 0 -1 0   0 0 0 0 -1 +1;...
%   nix nix 1 0 0 0 0 0;...
%   nix nix 0 0 0 0 0 1];
% beq = [zeros(T-1,1) ;e1 ;eT];

bineq = [];
Aineq = [];

% Aufrufen der cplex mip
x = linprog(f, Aineq, bineq, Aeq, beq, lb, ub);
service = x(1:T);
load = x(T+1:T*2);
hydro_kep = service - load;
end

 function output_vec = vec(length, positive_one, negative_one)
   output_vec = zeros(1,length);
   output_vec(positive_one) = 1;
   output_vec(negative_one) = -1;

 end