% 
% disp('Update graphic user interface');
% ntc
set(handles.tbl_ntc,'Data',handles.daten.ntc);
set(handles.tbl_ntc,'ColumnName',handles.config.marktgebiet(:,2));
set(handles.tbl_ntc,'RowName',handles.config.marktgebiet(:,2));

% Exporte
%if handles.config.status.imex == true
    set(handles.tbl_export,'Data',round(handles.daten.exporte{1,handles.config.t}));
    temp_string = get(handles.popup_plot,'String');
    temp_string{1} = 'Nachfrage & Lastsaldo';
    temp_string{4} = 'Marktpreis';
    set(handles.popup_plot,'String',temp_string);
%end
set(handles.tbl_export,'ColumnName',handles.config.marktgebiet(:,2));
set(handles.tbl_export,'RowName',handles.config.marktgebiet(:,2));

% Marktgebiet
    %Generiere Menu
    set(handles.popup_marktgebiet,'String',handles.config.marktgebiet(:,1));
    
    %kwpark
    kwpark = handles.daten.marktgebiet{handles.config.mg}.kwpark;
    psum = cumsum(kwpark(:,4));
    
    set(handles.tbl_kwpark,'Data',[kwpark psum]);
    set(handles.tbl_kwpark,'ColumnName',{'id' 'kvar' 'Pmin' 'Pmax' 'E00' 'Psum'});


    %nachfrage
    tempString = get(handles.popup_plot,'String');
    auswahl = tempString{get(handles.popup_plot,'Value')};
    switch auswahl
        case 'Nachfrage'
            % Nachfrage
            
            X = 1:1:handles.daten.T;
            Y = handles.daten.nachfrage(handles.config.mg,:);
            Ymax = max(Y)+1000;
            plot(X,Y)
            axis([1 handles.daten.T 0 Ymax]);
        case 'Merit Order'
            % Merit Order
            X = 1:1:handles.daten.marktgebiet{handles.config.mg}.Pges+1;
            Y = handles.daten.marktgebiet{handles.config.mg}.meritorder;
            plot(X,Y)
            axis ([1 max(X)+10 0 50]);
        case 'SEK-Kurve'
            % SEK-Kurve
            X = 0:1:handles.daten.marktgebiet{handles.config.mg}.Pges+1;
            Y = handles.daten.marktgebiet{handles.config.mg}.sekk;
            plot(X,Y)
            axis auto
        case 'Nachfrage & Lastsaldo'
            % Nachfrage
            X = 1:1:handles.daten.T;
            Y = handles.daten.nachfrage(handles.config.mg,:);
                          
            % Lastsaldo
            A = 1:1:handles.daten.T;
            B = handles.daten.load_balance(handles.config.mg,:);
            
            % bestimme Y-Abschnitt
            Ymax = max([Y B])+1000;
            
            plot(X,Y,'LineWidth',2)
            axis([1 handles.daten.T 0 Ymax]);
            hold on
            
            plot(A,B,'Color','r')
            
            hold off
        case 'Marktpreis'
            % Marktpreise t
            X = 1:1:handles.daten.T;
            Y = X;
            for t = 1 : handles.daten.T
                Pges = handles.daten.marktgebiet{handles.config.mg}.Pges;
                MeritOrderInput = round(min([max([1,handles.daten.load_balance(handles.config.mg,t)]),(Pges)+1]));
                testing = handles.config.mg;
                b = handles.daten.marktgebiet{testing};
               Y(t) = b.meritorder(1,MeritOrderInput);
            end
            
            % bestimme Y-Abschnitt
            Ymax = handles.config.pricecap+10;
            
            plot(X,Y)
            axis([1 handles.daten.T 0 120]);
     
        otherwise
           disp('Fehler im plot Menue');
         
    end
    

    
    % Popupmenu der Exportmatrix aktualisieren
        temp = cell(handles.daten.T,1);
        for t=1:handles.daten.T
            temp{t,1} = num2str(t);
        end
        set(handles.popup_export,'String',temp);
    
    % info
    infobox;
 
    guidata(hObject,handles);