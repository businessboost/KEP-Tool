function ntc_matrix = open_ntc_matrix(path,filename)
% input
  % path : string : path to the file e.g: "data/input"
  % filename : string : name of the ntc xlsx-file with e.g: "ntc.xlsx"

% output
  % ntc_matrix : double Matrix : each field contains the ntc-value
                               % between the market if the line to the market
                               % in of the row
disp(' net transfer capacity matrix ...');
[~,~,ntc_matrix] = xlsread([path '\' filename]);
% fill emtpy fields with a "0", because they are the upper bounds of the
% power flows. Empty cells would create a NaN in the calculations
        temp = cell2mat(ntc_matrix);
        temp(isnan(temp))=0;
        ntc_matrix = num2cell(temp);
end
