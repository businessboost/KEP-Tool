% Zuerst IBM CPLEX solver installieren
installationspfad = uigetdir('C:\\','Ordner wählen in den CPlex installiert wurde mit dem Namen IBM');
if strcmp(installationspfad(end-2:end),'IBM')
addpath([ installationspfad '\ILOG\CPLEX_Studio126\cplex\examples\src\matlab']);
addpath([ installationspfad '\ILOG\CPLEX_Studio126\cplex\matlab\x64_win64']);
else
  disp('Falscher Ordner ausgewählt. Bitte Ordner mit dem Namen IBM auswählen.')
  disp('Alternativ kann auch einfach per addpath()-Befehl ..\ILOG\CPLEX_Studio126\cplex\examples\src\matlab und ..\ILOG\CPLEX_Studio126\cplex\matlab\x64_win64 eingebunden werden.');
end