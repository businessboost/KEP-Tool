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

% Check for missing values
if strcmp(handles.config.pfad.eingangsdaten,'')
    handles.config.pfad.eingangsdaten = uigetdir('../Daten/', 'Bitte wählen Sie den Ordner mit den Eingangsdaten');
end

% Loading data
disp('Loading data:');
path = handles.config.pfad.eingangsdaten;
handles.daten.ntc       = open_ntc_matrix(path,handles.config.dateiname.ntc);
handles.daten.MG        = size(handles.daten.ntc,1);
handles.daten.nachfrage = open_demand(path,handles.config.dateiname.nachfrage);   
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