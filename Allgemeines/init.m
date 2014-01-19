function [export, load_balance, hydro] = init(MG,T,demand)

disp('Initialising')
    export = cell(1,T);
    for t = 1 : T
       export{1,t} = zeros(MG);
    end
    load_balance = demand;
    hydro = zeros(MG,1);
end