% main_data_open opens all files with the needed data for the kep
% Input: handles.daten.T
%        handles.daten.MG
%        handles.daten.ntc
%        handles.daten.marktgebiet{mg}.kwpark
%        handles.daten.nachfrage
% Output: handles.daten.marktgebiet{mg}.kep : MGxT cell : each cell
% contains a powerplant service plan
%       : handles.daten.exporte{t}
% Algorithm:
% Date:
% Version:
% Known bugs: 
% Version:
% Author:
% Functions used: opt_imex()
% Variables: sqrMG
%          : AlleKWParks
%          : t

% Declaration
% old: handles.daten.load_balance = zeros(handles.daten.MG,handles.daten.T);
array_parks = cell(handles.daten.MG,1);
array_hydro = cell(handles.daten.MG,1);

% create array of all parks
  for mg = 1 : handles.daten.MG
    array_parks{mg} = handles.daten.marktgebiet{mg}.kwpark;
    if strcmp(get(handles.menu_hydro_full,'Checked'),'on')
      array_hydro{mg} = handles.daten.marktgebiet{mg}.energiespeicher;
    else
      array_hydro = [];
    end
  end


% optimize imports and exports for all timesteps by the function opt_imex()
handles.daten.nachfrage_after_hydro = handles.daten.nachfrage;

  for t = 1 : handles.daten.T
    disp(['t = ' num2str(t)]);
      % full hydro
      if (size(array_hydro,2)>0)
        for mg = 1 : handles.daten.MG
          if (size(array_hydro{mg},2)>0)
           handles.daten.nachfrage_after_hydro(mg,t) = handles.daten.nachfrage(mg,t) - sum(array_hydro{mg}(:,4));  
          end
         end
      end
      
    [handles.daten.kep(1:handles.daten.MG,t), handles.daten.exporte{t}] = opt_imex(handles.daten.MG, cell2mat(handles.daten.ntc), handles.daten.nachfrage_after_hydro(:,t), array_parks, array_hydro);
    % calculate new load balances
    exports = handles.daten.exporte{t}; % eleganter mit dimension
    exportbalance = sum(exports')'; % eleganter mit dimension
    handles.daten.load_balance(:,t) = handles.daten.nachfrage(:,t) + exportbalance;
  end
  disp('Im- & exports optimized');