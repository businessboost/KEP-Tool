load('Daten\daten.mat');
handles.daten = daten;
load('Daten\config.mat');
handles.config = config;
clear daten config
updategui;
disp('Daten geladen');