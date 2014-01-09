disp('Daten werden gespeichert');
for mg = 1 : handles.daten.MG
    pfad = [handles.config.pfad.ausgangsdaten '\' handles.config.marktgebiet{mg,1} '.xlsx'];
    kwpark = handles.daten.marktgebiet{mg}.kwpark;
    anzahlKW = size(kwpark,1);
    
    kep = zeros(anzahlKW,handles.daten.T);
    exporte = zeros(1,handles.daten.T);
    for t = 1 : handles.daten.T
       temp = handles.daten.exporte{t};
       exporte(1,t) = sum(temp(mg,:)');
       kep(1:anzahlKW,t) =  handles.daten.marktgebiet{mg}.kep(1:anzahlKW,t);
    end
    exporte = [0 0 0 0 0 exporte];
    nachfrage = [0 0 0 0 0 handles.daten.nachfrage(mg,:);];
    pgesamt = [0 0 0 0 0 sum(kep)];
    
    ausgabe = sortrows([kwpark kep],1);
    ausgabe = [ausgabe;nachfrage;pgesamt;-exporte];
    
    xlswrite(pfad,ausgabe);
    
    % Auswertung
        nachfrage = [0 0 0 0 0 handles.daten.nachfrage(mg,:)];
    
end


% Auswertung
disp('Daten gespeichert');
