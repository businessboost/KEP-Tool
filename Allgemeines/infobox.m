    info{1} = ['Infos: '];
    info = [info;['-----------------------------']];
    info = [info;['Gesamt: ' handles.config.marktgebiet{handles.config.mg,2}] ':'];
    info = [info;['-----------------------------']];
    info = [info;['MG: ' num2str(handles.daten.MG)]];
    info = [info;['T : ' num2str(handles.daten.T)]];
    info = [info;['P_L_ges(t=' num2str(handles.config.t) '): ' num2str(sum(handles.daten.nachfrage(:,handles.config.t))/1000)]];
    if handles.config.status.imex
      E001_total = 0;
      E003_total = 0;
      for mg = 1:handles.daten.MG
        E001_total = sum(handles.daten.kep{mg,handles.config.t}) + E001_total;
        E003_total = handles.daten.total_hydro(mg,1) + E003_total;
      end
    info = [info;['P_E001:' num2str(E001_total/1000) ' GW']];
    info = [info;['P_E003:' num2str(E003_total /1000) ' GW']];
    info = [info;['P_E1+P_E3:' num2str((E001_total+E003_total)/1000) ' GW']];
    
    info = [info;['�ber:' num2str((handles.daten.total_hydro(handles.config.mg,1)+sum(handles.daten.kep{handles.config.mg,handles.config.t}))/1000-handles.daten.load_balance(handles.config.mg,handles.config.t)/1000) ' GW']];
    end
    info = [info;['-----------------------------']];
    info = [info;['Marktgebiet ' handles.config.marktgebiet{handles.config.mg,2}] ':'];
    info = [info;['-----------------------------']];
    info = [info;['Pges      : ' num2str(handles.daten.marktgebiet{handles.config.mg}.Pges/1000) ' GW']];
    info = [info;['Spizenlast: ' num2str(max(handles.daten.nachfrage(handles.config.mg,:))/1000) ' GW']];
    info = [info;['Grundlast : ' num2str(min(handles.daten.nachfrage(handles.config.mg,:))/1000) ' GW']];
    info = [info;['Energie   : ' num2str(sum(handles.daten.nachfrage(handles.config.mg,:))/1000000) ' TWh']];
    info = [info;['-----------------------------']];
    info = [info;['Zeitpunkt t = ' num2str(handles.config.t)] ':'];
    info = [info;['-----------------------------']];
    leistungsflussmatrix = handles.daten.exporte{1,handles.config.t};
    Pexport = leistungsflussmatrix(handles.config.mg,:);
    Pexport(Pexport <0)=0;
    
    Pimport = leistungsflussmatrix(:,handles.config.mg);
    Pimport(Pimport <0)=0;
    info = [info;['Pres   :' num2str(handles.daten.nachfrage(handles.config.mg,handles.config.t)/1000) ' GW']];
    info = [info;['Pexport:' num2str(sum(Pexport)/1000) ' GW']];
    info = [info;['Pimport:' num2str(sum(Pimport)/1000) ' GW']];
    info = [info;['Psaldo :' num2str(handles.daten.load_balance(handles.config.mg,handles.config.t)/1000) ' GW']];
    if handles.config.status.imex
    info = [info;['P_E001:' num2str(sum(handles.daten.kep{handles.config.mg,handles.config.t})/1000) ' GW']];
    info = [info;['P_E003:' num2str(handles.daten.total_hydro(handles.config.mg,1)/1000) ' GW']];
    info = [info;['P_E1+P_E3:' num2str((handles.daten.total_hydro(handles.config.mg,1)+sum(handles.daten.kep{handles.config.mg,handles.config.t}))/1000) ' GW']];
    
    info = [info;['�ber:' num2str((handles.daten.total_hydro(handles.config.mg,1)+sum(handles.daten.kep{handles.config.mg,handles.config.t}))/1000-handles.daten.load_balance(handles.config.mg,handles.config.t)/1000) ' GW']];
    end
    if handles.config.status.mp 
    MeritOrderInput = min([max([1,handles.daten.load_balance(handles.config.mg,handles.config.t)]),(handles.daten.marktgebiet{handles.config.mg}.Pges)+1]);
    mp = handles.daten.marktgebiet{handles.config.mg}.meritorder(MeritOrderInput);
    info = [info;['mp     :' num2str(mp) ' �']]; 
    end; 
    
    set(handles.info,'String',info);