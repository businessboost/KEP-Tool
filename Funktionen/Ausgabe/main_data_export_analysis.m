disp('Exporting data for analysis');

header = {'$Bez. SO'	'Bezeichner'	'Langname'	'$UKZ'	'$Kurzname'	'$Un' 'P min' 'P max'};
for t = 1 : handles.daten.T
  temp = ['NNF_' num2str(t)];
  header = [header temp];
end

mkdir([handles.config.pfad.ausgangsdaten '\' string_datum '-KEP']);

content = [];
for mg=1:handles.daten.MG    
    % konventionell
    kwpark =  handles.daten.marktgebiet{mg}.kwpark;
    KW_normal = size(kwpark,1); % Bestimmen der Anzahl der Kraftwerke KW des Marktgebietes 
    kep_normal = num2cell(zeros(KW_normal,8+handles.daten.T)); % Initialisieren des KEP
    % UKZ bestimmen für jede Zeile
    for kw = 1 : KW_normal
        kep_normal{kw,4} = handles.config.marktgebiet{mg,2};
        id = kwpark(kw,1);
        index=find(cell2mat(handles.daten.marktgebiet{mg}.id)==id,2);
        kep_normal{kw,1} = handles.daten.marktgebiet{mg}.bezSO{index};
        kep_normal{kw,2} = handles.daten.marktgebiet{mg}.bezeichner{index};
        kep_normal{kw,3} = handles.daten.marktgebiet{mg}.langname{index};
        kep_normal{kw,5} = handles.daten.marktgebiet{mg}.kurzname{index};
        kep_normal{kw,6} = handles.daten.marktgebiet{mg}.Un{index};
        kep_normal{kw,7} = handles.daten.marktgebiet{mg}.Pmin{index};
        kep_normal{kw,8} = handles.daten.marktgebiet{mg}.Pmax{index};
        for t = 1 : handles.daten.T
          kep_normal{kw,8+t} = handles.daten.kep{mg,t}(kw,1);
        end
    end
    
    % hydro
    kwpark =  handles.daten.marktgebiet{mg}.energiespeicher;
    KW_hydro = size(kwpark,1); % Bestimmen der Anzahl der Kraftwerke KW des Marktgebietes 
    kep_hydro = num2cell(zeros(KW_hydro,8+handles.daten.T)); % Initialisieren des KEP
    % UKZ bestimmen für jede Zeile
    for kw = 1 : KW_hydro
        kep_hydro{kw,4} = handles.config.marktgebiet{mg,2};
        id = kwpark(kw,1);
        index=find(cell2mat(handles.daten.marktgebiet{mg}.id)==id,2);
        kep_hydro{kw,1} = handles.daten.marktgebiet{mg}.bezSO{index};
        kep_hydro{kw,2} = handles.daten.marktgebiet{mg}.bezeichner{index};
        kep_hydro{kw,3} = handles.daten.marktgebiet{mg}.langname{index};
        kep_hydro{kw,5} = handles.daten.marktgebiet{mg}.kurzname{index};
        kep_hydro{kw,6} = handles.daten.marktgebiet{mg}.Un{index};
        kep_hydro{kw,7} = handles.daten.marktgebiet{mg}.Pmin{index};
        kep_hydro{kw,8} = handles.daten.marktgebiet{mg}.Pmax{index};
        for t = 1 : handles.daten.T
          if strcmp(get(handles.menu_hydro_full,'Checked'),'on')
            kep_hydro{kw,8+t} = handles.daten.marktgebiet{mg}.Pmax{index};
            else
              kep_hydro{kw,8+t} = 0;
            end
        end
    end
    
    content = [content; kep_normal;kep_hydro];
        
end
content = [header;content];
string_ordnername = [handles.config.pfad.ausgangsdaten '\' string_datum '-KEP'];
string_dateiname = [string_ordnername '\E001_u_E003_alle_NNF.csv'];
cellwrite_german(string_dateiname,content);

disp('Data for Analysis exportet');