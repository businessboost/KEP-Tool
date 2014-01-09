function merit_order = create_merit_order(thermo_park)
% merit_order creates the merit order of the given thermic powerplantpark
% 
% Input: thermo_parc (PPx5 double), thermic powerplantpark,
                                    % 2nd colum are the variable costs,
                                    % 4th column is the maximum Power of
                                    % the powerplants
% Output: merit_order (1xtotal_power double), function that gives the costs
                                            % of producing power by the
                                            % amount of the inex
% Algorithm: creates the merit order by sorting the capacities of the
%            powerplants by variable costs
% Date: 05.01.2014
% Version: 1.0
% Known bugs: none
% Functions used: nothing special
% Variables: total_power (double): total power that the powerplants of the market may produce
%            PP (integer) : number of thermic powerplants in a market ( KW = german Kraftwerk )
%            pp (integer) : index of the powerplant
%            p  (integer) : power to produce, index for the merit order
  thermo_park = sortrows(thermo_park,2); % sorts the powerplants by the variable costs
  total_power = sum(thermo_park(:,4)); % total power ist the sum of all Pmax
  PP = size(thermo_park,1); % counting the amount of powerplants
  merit_order = zeros(1,total_power+1); % creating the merit order, +1 because of the last value for inf
  % Starting by 1 creating the merit order by sorting the variable costs
  p = 1; 
  for pp = 1 : PP
    Pmax = thermo_park(pp,4);
    merit_order(1,p:p-1+Pmax) = ones(1,Pmax)*thermo_park(pp,2);
    p = p + Pmax;
  end
  merit_order(1,end) = inf;
end

