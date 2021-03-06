% main_data_open opens all files with the needed data for the kep
% Input:
% Output:
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

handles.config.pfad.eingangsdaten = uigetdir('Daten/', 'Bitte w�hlen Sie den Ordner mit den Eingangsdaten');
if (handles.config.pfad.eingangsdaten~=0)
  % Loading data
  disp('Loading data:');
  path = handles.config.pfad.eingangsdaten;
  handles.daten.ntc       = open_ntc_matrix(path,handles.config.dateiname.ntc);
  handles.daten.MG        = size(handles.daten.ntc,1);
  handles.daten.nachfrage = open_demand(path,handles.config.dateiname.nachfrage);  
  % main_data_open_entsoe;
  handles.daten.T         = size(handles.daten.nachfrage,2);

  % loading powerplantparks
  tag_thermo = cell(handles.daten.MG,8);
  for mg = 1 : handles.daten.MG

  [handles.daten.marktgebiet{mg}.kwpark, tag_thermo, handles.daten.marktgebiet{mg}.energiespeicher] = open_powerplant_park(path,handles.config.dateiname.kwpark{1},handles.config.marktgebiet{mg,1},handles.config.dateiname.kwpark{2});

        handles.daten.marktgebiet{mg}.bezSO       = tag_thermo{1};
        handles.daten.marktgebiet{mg}.bezeichner  = tag_thermo{2};
        handles.daten.marktgebiet{mg}.langname    = tag_thermo{3};
        handles.daten.marktgebiet{mg}.Un          = tag_thermo{4};
        handles.daten.marktgebiet{mg}.kurzname    = tag_thermo{5};
        handles.daten.marktgebiet{mg}.id          = tag_thermo{6};
        handles.daten.marktgebiet{mg}.Pmin        = tag_thermo{7};
        handles.daten.marktgebiet{mg}.Pmax        = tag_thermo{8};
  end
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % calculate Merit Order and total powers
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  disp('Calculating merit orders and total powers');
  handles.daten.Pges = zeros(handles.daten.MG,1); % F001 Relevanz pr�fen
  for mg = 1:handles.daten.MG
    % Calucalting Pges
    handles.daten.marktgebiet{mg}.Pges = sum(handles.daten.marktgebiet{mg}.kwpark(:,4));
    % create merit order for market mg
    handles.daten.marktgebiet{mg}.meritorder = create_merit_order(handles.daten.marktgebiet{mg}.kwpark);
    % calculate total_power for market mg, as witdh of costingcurves
    handles.daten.Pges(mg,1) = handles.daten.marktgebiet{mg}.Pges; % F001 Relevanz pr�fen
    % calculate costingcurve for market mg
    handles.daten.marktgebiet{mg}.sekk = [0 cumsum(handles.daten.marktgebiet{mg}.meritorder)];
  end
  handles.daten.MaxPges = max(handles.daten.Pges); % F001 Relevanz pr�fen
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  % Init export and load_balance
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  [handles.daten.exporte, handles.daten.load_balance, handles.daten.total_hydro] = init(handles.daten.MG,handles.daten.T,handles.daten.nachfrage);
end
