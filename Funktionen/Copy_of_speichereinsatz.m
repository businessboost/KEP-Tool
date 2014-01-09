% Eingabe
disp('Teste CPLEX');
addpath('C:\Program Files\IBM\ILOG\CPLEX_Studio_Preview125\cplex\matlab\x64_win64');
    % Daten Laden
        % Lade Residuallast für Deutschland (eigentlich Lastsaldo)
        disp('Lastsaldo für Deutschland wird geladen');
        [~,~,handles.test.lastsaldo]=xlsread([handles.config.pfad.eingangsdaten '/lastsaldo.xlsx']);
        handles.test.lastsaldo = cell2mat(handles.test.lastsaldo)';
        handles.test.T = size(handles.test.lastsaldo,2);
        
        % Lade thermischen Kraftwerkspark für Deutschland
        disp('Kraftwerkspark wird geladen');
        handles.test.kwpark = handles.daten.marktgebiet{11}.kwpark;
        handles.test.KWthermisch = size(handles.test.kwpark,1);
    
    % Datenaufbereitung 
        % Erstelle Merit Order
        handles.test.pges = sum(handles.test.kwpark(:,4));
        meritorder = zeros(1,handles.test.pges + 1);
        
        meritorder(1,end) = inf;
        p = 1;
        for kw = 1 : handles.test.KWthermisch
            pmaxkw = handles.test.kwpark(kw,4);
            meritorder(1,p:p-1+pmaxkw) = ones(1,pmaxkw)*handles.test.kwpark(kw,2);
            p = p + pmaxkw;
        end
        
        
% Verarbeitung
    % Ermittle Marktpreiszeitreihe mit Merit Order und Lastsaldo
    handles.test.marktpreis = zeros(1,handles.test.T);
    for t = 1 : handles.test.T
        handles.test.marktpreis(1,t) = meritorder(1,(min([max([1,handles.test.lastsaldo(1,t)]),(handles.test.pges+1)])));
    end
    mp = handles.test.marktpreis(1,:);
    k = handles.test.marktpreis.*0.85;
    nullvektor = zeros(1,744);
    % Erstelle das Optimierungsproblem für CPLEX
        % SetUp
        T = handles.test.T;
        
        % Erstelle Energiespeicher [E1, ET, Emax, Pmin, Pmax, eta]
        Pmax = 4;
        Pmin = -3;
        eta = 0.5;
        e1 = 5;
        eT = 5;
        Emax = 10;
        
        % Kleines Problem
        nix = zeros(1,T);
        da = ones(1,T);
        pmax = Pmax*ones(1,T);
        pmin = Pmin*ones(1,T);
        emax = Emax*ones(1,T);

        f = [-mp k nix];
        lb = [nix nix nix];
        ub = [pmax -pmin emax];
        beq = [zeros(T-1,1) ;e1 ;eT];
%         Aeq = ...
%         [ 1 0 0 0 0 0  -1 0 0 0 0 0  -1 +1 0 0 0 0;...
%           0 1 0 0 0 0  0 -1 0 0 0 0   0 -1 +1 0 0 0;...
%           0 0 1 0 0 0  0 0 -1 0 0 0   0 0 -1 +1 0 0;...
%           0 0 0 1 0 0  0 0 0 -1 0 0   0 0 0 -1 +1 0;...
%           0 0 0 0 1 0  0 0 0 0 -1 0   0 0 0 0 -1 +1;...
%           nix nix 1 0 0 0 0 0;...
%           nix nix 0 0 0 0 0 1]
        Aeq = zeros(T+1,T*3);
        for t = 1 : T-1
            a = zeros(1,T);
            b = zeros(1,T);
            c = zeros(1,T);
            a(1,t) = 1;
            b(1,t) = -1;
            c(1,t) = -1;
            c(1,t+1) = 1;
            Aeq(t,:) = [a b c];    
        end
            a = zeros(1,T);
            b = zeros(1,T);
            c = zeros(1,T);
            c(1,1) = 1;
            Aeq(end-1,:) = [a b c];
            a = zeros(1,T);
            b = zeros(1,T);
            c = zeros(1,T);
            c(1,end) = 1;
            Aeq(end,:) = [a b c];
            
      
        bineq = [];
        Aineq = [];
        
        % Aufrufen der cplex mip
        x = cplexlp(f, Aineq, bineq, Aeq, beq, lb, ub);

    

    
% Ausgabe der Ergebnisse


disp('CPLEX fertig');
