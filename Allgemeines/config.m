%Namen und Kennzeichnung der Marktgebiet: 
    %(Reihenfolge muss der NTC-Matrix und Nachfragematrix entsprechen)

handles.config.pfad.daten = '';
handles.config.pfad.eingangsdaten = '';
handles.config.pfad.ausgangsdaten = '';



handles.config.marktgebiet = {
'Belgien'       'B'       'BE';
'Dänemark_Ost'  'DK_O'    'DK'; %Muss noch gesplittet werden
'Dänemark_West' 'DK_W'    'DK'; %Muss noch gesplittet werden
'Frankreich'    'F'       'FR';
'Niederlande'   'N'       'NL';
'Österreich'    'O'       'AT';
'Polen'         'Z'       'PL';
'Schweiz'       'S'       'CH';
'Tschechien'    'C'       'CZ';
'Deutschland'   'D'       'DE'  % Hier muss noch LU dazu
};
 

handles.config.dateiname.ntc        = 'ntc.xlsx';
handles.config.dateiname.nachfrage  = 'nachfrage.xlsx';
handles.config.dateiname.kwpark     = {'Netzeinspeisungen-E001-E003-' '.xlsx'}; %Der Dateiname muss den Namen des Marktgebietes enthalten

handles.config.Spalte_KW_id        =   'A'; %Eindeutige id       des KW
handles.config.Spalte_KW_Pmin      =   'K'; %Minimalleistung     des KW
handles.config.Spalte_KW_Pmax      =   'J'; %Maximalleistung     des KW
handles.config.Spalte_KW_eta       =   'G'; %Wirkungsgrad        des KW 
handles.config.Spalte_KW_e         =   'H'; %Emissionsgrad       des KW
handles.config.Spalte_KW_kb        =   'I'; %Brennstoffkosten    des KW
handles.config.Spalte_KW_kurzname  =   'C'; %ob E001 oder E003
handles.config.Spalte_KW_typ       =   'F'; %Primärenergietyp    des KW

handles.config.Spalte_KW_bezSO     =   'B';
handles.config.Spalte_KW_bezeichner=   'E'; %Entspricht Kurzname!
handles.config.Spalte_KW_langname  =   'F';
%handles.config.Spalte_KW_ukz       =   'A'; %Wird bei Ausgabe erstellt
%handles.config.Spalte_KW_kurzname  =   'B'; %Schon bestimmt
handles.config.Spalte_KW_Un        =   'D';

handles.daten.co2preis             = 12;

% Anmerkungen:
    % KWParkDatei sollte keine Spalten enthalten
    % KWParkDatei hat eine Kopfzeile mit vollständigen Bezeichnungen
    % Wirkungsgrad sollte größer 0 sein und eingetragen
    % id hat ein festes Konstrukt: "DK_004"
    
addpath('Daten');
% Problem, da config auch als variablenname

% temporäre Einstellungen
handles.config.mg = 1;
handles.config.t = 1;

handles.config.status.imex = false;
handles.config.status.mp = false;

% statt unendlich wird eine maximaler Marktpreis benötigt: Einfach große
% Zahl angeben:
handles.config.pricecap = inf;

% Admineinstellungen
handles.config.doc = true;

%Cplex Solver einbinden
addpath('IBM Cplex Solver/x64_win64/');
