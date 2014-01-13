disp('Daten werden für Integral gespeichert');
% Variablen
    % Beschriftung der KEPs für die Zeitpunkte
    kopfzeile = {'$Bez. SO'	'Bezeichner'	'Langname'	'$UKZ'	'$Kurzname'	'$Un' 'P min' 'P0' 'P max'};
    ausgabe_leistungsflusszeitreihen = zeros(handles.daten.MG*handles.daten.MG,handles.daten.T);
    ausgabe_beschriftung_kopfzeile = {'Nr.' 'Von' 'Nach' 'Pmax' 'NNF_Pmax' 'Pmin' 'NNF_Pmin'};

% Ordnername der Ausgabe
    % Datum
    % Optional: KEP-Nummer für Datum



%für jeden NNF csv datei schreiben
for t=1:handles.daten.T
    % Ordner für NNF erstellen
    
    
    inhalt = kopfzeile;
    %für jedes Marktgebiet Datensätze holen
    for mg=1:handles.daten.MG
        % for normal PP
        kwpark = handles.daten.marktgebiet{mg}.kwpark;
        KW_normal = size(kwpark,1); % Bestimmen der Anzahl der Kraftwerke KW des Marktgebietes 
        kep_normal = num2cell(zeros(KW_normal,9)); % Initialisieren des KEP
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
            kep_normal{kw,9} = handles.daten.marktgebiet{mg}.Pmax{index};
            kep_normal{kw,8} = handles.daten.kep{mg,t}(kw);
            
        end
        
        % for hydro PP
        kwpark = handles.daten.marktgebiet{mg}.energiespeicher;
        KW_hydro = size(kwpark,1); % Bestimmen der Anzahl der Kraftwerke KW des Marktgebietes 
        kep_hydro = num2cell(zeros(KW_hydro,9)); % Initialisieren des KEP
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
            kep_hydro{kw,9} = handles.daten.marktgebiet{mg}.Pmax{index};
            if strcmp(get(handles.menu_hydro_full,'Checked'),'on')
              kep_hydro{kw,8} = handles.daten.marktgebiet{mg}.Pmax{index};
            else
              kep_hydro{kw,8} = 0;
            end
        end
        
        inhalt = [inhalt;kep_normal;kep_hydro];
    end
    string_ordnername = [handles.config.pfad.ausgangsdaten '\' string_date '-KEP' '\NNF-' num2str(t)];
    mkdir(string_ordnername);
    string_dateiname = [string_ordnername '\E001_u_E003.csv'];
    
    inhalt = sortcell(inhalt,[4 1]);



    % Zusammenfassen der Daten
    zeiger = 1; 
    while zeiger<size(inhalt,1)
        if strcmp(inhalt{zeiger,1},inhalt{zeiger+1,1})%&& strcmp(inhalt{zeiger,5},'E001')
           inhalt{zeiger,7} = min([inhalt{zeiger,7} inhalt{zeiger+1,7}]);
           inhalt{zeiger,8} = inhalt{zeiger,8}+inhalt{zeiger+1,8};
           inhalt{zeiger,9} = inhalt{zeiger,9}+inhalt{zeiger+1,9};
           inhalt(zeiger+1,:) =[];
        else
            zeiger = zeiger+1;
        end
    end
    cellwrite_german(string_dateiname,inhalt);
    
    % Kofpzeile erweitern
    temp = ['NNF_' num2str(t)];
    ausgabe_beschriftung_kopfzeile = [ausgabe_beschriftung_kopfzeile temp];
    
    % Exporte speichern
    zeilenindex = 1;
    temp = handles.daten.exporte{t};
    for i=1:handles.daten.MG
        for j=1:handles.daten.MG
           ausgabe_leistungsflusszeitreihen(zeilenindex,t) = temp(i,j);
           zeilenindex =zeilenindex + 1;
        end        
    end
    
end





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% create "Zeitreihen_Handel.csv"
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Beschriftung erstellen
ausgabe_beschriftung = cell(handles.daten.MG*handles.daten.MG,7);
    zeilenindex = 1;
    for i=1:handles.daten.MG
        for j=1:handles.daten.MG
           ausgabe_beschriftung{zeilenindex,1} = zeilenindex;                                           %Nr
           ausgabe_beschriftung{zeilenindex,2} = handles.config.marktgebiet{i,2};                       %Von
           ausgabe_beschriftung{zeilenindex,3} = handles.config.marktgebiet{j,2};                       %Nach
           [ausgabe_beschriftung{zeilenindex,4}, ausgabe_beschriftung{zeilenindex,5}] = max(ausgabe_leistungsflusszeitreihen(zeilenindex,:));  %Pmax
           [ausgabe_beschriftung{zeilenindex,6}, ausgabe_beschriftung{zeilenindex,7}] = min(ausgabe_leistungsflusszeitreihen(zeilenindex,:));  %Pmax
           zeilenindex = zeilenindex + 1;
        end        
    end

ausgabe_zeitreihenhandel = [ausgabe_beschriftung_kopfzeile;ausgabe_beschriftung num2cell(ausgabe_leistungsflusszeitreihen)];
cellwrite_german([handles.config.pfad.ausgangsdaten '\' string_date '-KEP' '\Zeitreihen_Handel.csv'],ausgabe_zeitreihenhandel);

disp('Daten für Integral gespeichert');