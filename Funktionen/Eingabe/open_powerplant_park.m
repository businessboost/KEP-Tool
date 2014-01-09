function [thermo_park, tag_thermo, hydro_park] = open_powerplant_park (path,filename_a,market_name,filename_b)
% input
  % path
  % filename_a
  % market_name
  % filename_b

% aux
  % input_all
  % input_string
  % input_double
  % KW
  % KW_Pmin
  % ...
  % KW_kvar
  
% output
  % thermo_park
  % tag_thermo
  % hydro_park


disp([' powerplantpark of ' market_name]);
[~,input_string,input_double]=xlsread([path '/' filename_a market_name filename_b]);

 % Clean matrix
    input_double = cutnan(input_double); % cut off after values
    input_double = cleancell(input_double(2:end,:)); % replacing NaN by 0
    
 % counting the powerplants in the market
    KW = size(input_double,1);
    
 % getting data
    KW_Pmin = cell2mat(input_double(1:KW,col2num(settings('Spalte_KW_Pmin'))));
    KW_Pmax = ceil(cell2mat(input_double(1:KW,col2num(settings('Spalte_KW_Pmax')))));
    KW_eta = cell2mat(input_double(1:KW,col2num(settings('Spalte_KW_eta'))));
    KW_eta(KW_eta==0) = 0.00001;
    KW_e = cell2mat(input_double(1:KW,col2num(settings('Spalte_KW_e'))));
    KW_kb = cell2mat(input_double(1:KW,col2num(settings('Spalte_KW_kb'))));
    % KW_id:
      input_spalte_id = input_string(2:end,col2num(settings('Spalte_KW_id')));
      KW_id = zeros(KW,1);
      for kw=1:KW
        % Cut off UKZ
        temp = input_spalte_id(kw,1);
        temp = temp{1};
        temp = temp(4:end);
        KW_id(kw,1)=  str2num(temp);
      end
     % KW_kurzname
       input_spalte_kurzname = input_string(2:end,col2num(settings('Spalte_KW_kurzname')));
       KW_kurzname = zeros(KW,1);
       for kw=1:KW
        % Cut off "E00"
        temp = input_spalte_kurzname(kw,1);
        temp = temp{1};
        temp = temp(4);
        KW_kurzname(kw,1)=  str2num(temp);
       end
        
      % creating tag for thermo_park
      tag_thermo{1} = input_string(2:end,col2num(settings('Spalte_KW_bezSO')));
      tag_thermo{2} = input_string(2:end,col2num(settings('Spalte_KW_bezeichner')));
      tag_thermo{3} = input_string(2:end,col2num(settings('Spalte_KW_langname')));
      tag_thermo{4} = input_double(:,col2num(settings('Spalte_KW_Un')));
      tag_thermo{5} = input_string(2:end,col2num(settings('Spalte_KW_kurzname')));
      tag_thermo{6} = num2cell(KW_id);
      tag_thermo{7} = num2cell(KW_Pmin);
      tag_thermo{8} = num2cell(KW_Pmax);
   

        
    % Calculate kvar
    KW_kvar = KW_kb./KW_eta + settings('co2preis')*KW_e./KW_eta;

    % put the data together to a park
    KWPark = [KW_id KW_kvar KW_Pmin KW_Pmax KW_kurzname];
    
    % split thermo_park and hydro_park
    t = 0; % Index thermisch
    h = 0; % Index hydraulisch
    thermo_park = [];
    hydro_park = [];
    for kw=1:KW
        if (KWPark(kw,5)==1)
            t = t+1;
            thermo_park(t,:) = KWPark(kw,:);
        elseif (KWPark(kw,5)==3)
            h = h+1;
            hydro_park(h,:) = KWPark(kw,:);
        end
    end
end