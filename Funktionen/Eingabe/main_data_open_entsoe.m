disp(' entsoe demand ...');

path_demand = 'C:\Users\mseiffart\repositories\KEP-Tool\Daten\beispiel_1\Eingangsdaten';
filename_demand = 'entsoe_demand.xls';
 [~,~,demand]=xlsread([path_demand '/' filename_demand]);
 handles.daten.T = 744;
 handles.daten.MG = 10;
 handles.daten.nachfrage = zeros(handles.daten.MG,handles.daten.T);
 for mg = 1 : handles.daten.MG
   UKZ = handles.config.marktgebiet{mg,3};
   line = 11;
   day = 0;
   while line<=size(demand,1)
     if strcmp(demand{line,1},UKZ)
       links = (day*24+1);
       rechts = (day*24+24);
       inhalt =  cell2mat(demand(line,3:26));
       handles.daten.nachfrage(mg,links:rechts) = inhalt;   
       day = day + 1;
     end
     line = line + 1;
   end
   if strcmp(UKZ,'DK')
     disp('Die Nachfrage Dänemarks wird halbiert');
     handles.daten.nachfrage = handles.daten.nachfrage/2;
   end
   
   
 end;