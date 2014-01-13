% To Do: transform export scripts to functions

% Choose Path for Data
handles.config.pfad.ausgangsdaten = uigetdir('Daten/', 'Bitte wählen Sie den Ordner für die Ausgangsdaten');

% Create Folder with Name: Date - Time - KEP
string_date = strrep(datestr(now), ':', '_');
string_date(15) = 'h';
string_date(18) = 'm';
string_date(21) = 's';
foldername = [string_date '-KEP'];
folderpath = [handles.config.pfad.ausgangsdaten '\' foldername];
mkdir(folderpath);

% Export Data into Folder
data_export_integral;
data_export_analysis;