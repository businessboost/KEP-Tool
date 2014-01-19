% Functions used: create_merit_order()
% Input    : handles.daten.marktgebiet{mg}.kwpark
% Output   : handles.daten.marktgebiet{mg}.meritorder   
%          : handles.daten.Pges(mg,1) F001 needed?
%          : handles.daten.marktgebiet{mg}.sekk
%          : handles.daten.MaxPges
%          : handles.daten.exporte{1,t}
%          : handles.daten.lastsaldo
disp('Initialising')
disp('Calculating merit orders and total powers');
handles.daten.Pges = zeros(handles.daten.MG,1); % F001 Relevanz prüfen
for mg = 1:handles.daten.MG
  % Calucalting Pges
  handles.daten.marktgebiet{mg}.Pges = sum(handles.daten.marktgebiet{mg}.kwpark(:,4));
  % create merit order for market mg
  handles.daten.marktgebiet{mg}.meritorder = create_merit_order(handles.daten.marktgebiet{mg}.kwpark);
  % calculate total_power for market mg, as witdh of costingcurves
  handles.daten.Pges(mg,1) = handles.daten.marktgebiet{mg}.Pges; % F001 Relevanz prüfen
  % calculate costingcurve for market mg
  handles.daten.marktgebiet{mg}.sekk = [0 cumsum(handles.daten.marktgebiet{mg}.meritorder)];
end
handles.daten.MaxPges = max(handles.daten.Pges); % F001 Relevanz prüfen
    
% handles.daten.status.imex = false; % setting for user interface

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    handles.daten.export = cell(1,handles.daten.T);
    for t = 1 : handles.daten.T
       handles.daten.exporte{1,t} = zeros(handles.daten.MG);
    end
    handles.daten.load_balance = handles.daten.nachfrage;
    
disp('Update graphic user interface')
handles.config.mg = 1;
set(handles.popup_plot,'Value',1);