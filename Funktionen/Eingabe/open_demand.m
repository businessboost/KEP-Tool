function demand = open_demand(path,filename)
% input
  % path : string : path to the file e.g: "data/input"
  % filename : string : name of the demand xlsx-file with e.g: "demand.xlsx"
  
% output
  % demand : 

disp(' demand ...');
 [~,~,demand]=xlsread([path '/' filename]);
 demand = cell2mat(demand);


 
end
    
