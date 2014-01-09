 % Erstelle Energiespeicher [E1, ET, Emax, Pmin, Pmax, eta]
 function hydro_kep = opt_hydro(mp,eta,Pmin,Pmax,Emax, E1, ET)
  % main_data_open opens all files with the needed data for the kep
  % Input: mp (1xT double) : market price  
  %      : Pmin (double) : minimum service (negative) ->|Pmin|: maximum load
  %                                                      performance
  %      : Pmax (double) : maximum service 
  %      : Emax (double) : maximum capacity
  %      : E1 (double) : load in beginning
  %      : ET (double) : load in the end
  % Output: hydro_kep (1xT double) : service of hydraulic power plant
  % Algorithm:
  % Date:
  % Version:
  % Known bugs: 
  % Version:
  % Author:
  % Functions used : open_powerplant_park()
  %                : open_ntc_matrix()
  %                : open_demand()
  % Variables:
Pmax = 4;
Pmin = -3;
eta = 0.5;
e1 = 5;
eT = 5;
Emax = 10; 
mp = [10 6 8 2 10 2];

T = size(mp,2);
costs = mp.*eta;

nix = zeros(1,T);
pmax = Pmax*ones(1,T);
pmin = Pmin*ones(1,T);
emax = Emax*ones(1,T);
f = [-mp k nix];
lb = [nix nix nix];
ub = [pmax -pmin emax];

Aeq = [];
for i = 1 : T-1
  line = [vec(T,i,[]),vec(T,[],i),vec(T,i+1,i)];
  Aeq = [Aeq;line];
end

Aeq = ...
[ 1 0 0 0 0 0  -1 0 0 0 0 0  -1 +1 0 0 0 0;...
  0 1 0 0 0 0  0 -1 0 0 0 0   0 -1 +1 0 0 0;...
  0 0 1 0 0 0  0 0 -1 0 0 0   0 0 -1 +1 0 0;...
  0 0 0 1 0 0  0 0 0 -1 0 0   0 0 0 -1 +1 0;...
  0 0 0 0 1 0  0 0 0 0 -1 0   0 0 0 0 -1 +1;...
  nix nix 0 0 0 0 0 1;...
  nix nix 1 0 0 0 0 0];
beq = [zeros(T-1,1) ;eT ;e1];

bineq = [];
Aineq = [];

% Aufrufen der cplex mip
x = linprog(f, Aineq, bineq, Aeq, beq, lb, ub);
 end

 function output_vec = vec(length, positive_ones, negative_ones)
   output_vec = zeros(length);
   for i = 1 : size(positive_ones)
    output_vec(postive_ones(i)) = 1;
   end
   
   for j = 1 : size(negative_ones)
    output_vec(postive_ones(i)) = -1;
   end
 end