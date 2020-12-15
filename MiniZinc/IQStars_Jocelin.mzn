% Données

int: N = 7;  % Nombre de pièces
int: size_max = 4;  % Nombre maximal de morceaux d'une pièce
int: n_orientation = 6;
array[1..N,1..n_orientation] of int: widths_e =
  array2d(1..N,1..n_orientation,
    [
      3, 2, 2, 0, 0, 0, % 1
      
      3, 3, 0, 3, 0, 3, % 2
      
      2, 3, 2, 2, 3, 2, % 3
      
      2, 3, 3, 3, 3, 2, % 4
      
      3, 0, 0, 0, 0, 0, % 5
      
      2, 3, 2, 2, 3, 1, % 6
      
      3, 2, 3, 3, 2, 2  % 7
    ]);
 
array[1..N,1..n_orientation] of int: widths_u =
  array2d(1..N,1..n_orientation,
    [
      3, 2, 2, 0, 0, 0, % 1
      
      4, 3, 2, 3, 2, 4, % 2
      
      2, 3, 3, 2, 3, 2, % 3
      
      3, 3, 2, 2, 3, 3, % 4
      
      2, 0, 0, 0, 0, 0, % 5
      
      3, 2, 1, 3, 2, 3, % 6
      
      3, 2, 2, 3, 2, 3  % 7
    ]);

% Formes des pièces en hauteur paire
array[1..N,1..n_orientation,1..size_max] of int: mxe =
  array3d(1..N,1..n_orientation,1..size_max,
    [
      0,1,2,2,  %O11
      0,1,1,1,  %O12
      1,1,0,0,  %O13
      0,0,0,0,
      0,0,0,0,
      0,0,0,0,
    
      0,1,2,0,  %O21
      0,1,2,2,  %O22
      0,0,0,0,  %O23
      0,1,1,2,  %O24
      0,0,0,0,  %O25
      2,0,1,2,  %O26
    
      1,1,0,1,  %O31
      0,1,2,1,  %O32
      0,0,1,1,  %O33
      0,1,1,0,  %O34
      1,0,1,2,  %O35
      0,1,1,0,  %O36
    
      0,1,0,0,  %O41
      0,1,0,2,  %O42
      0,1,2,1,  %O43
      1,2,0,1,  %O44
      0,2,1,2,  %O45
      0,0,0,1,  %O46
    
      0,1,1,2,  %O51
      0,1,0,1,  %O52
      0,0,1,0,  %O53
      0,0,0,0,
      0,0,0,0,
      0,0,0,0,
    
      0,1,0,0,  %O61
      0,1,2,2,  %O62
      0,1,0,0,  %O63
      1,0,1,1,  %O64
      0,1,2,2,  %O65
      0,0,0,0,  %O66
    
      0,0,1,2,  %O71
      0,1,1,1,  %O72
      1,1,2,0,  %O73
      0,1,2,2,  %O74
      0,1,0,1,  %O75
      1,0,1,0   %O76
    ]);

array[1..N,1..n_orientation,1..size_max] of int: mxu =
  array3d(1..N,1..n_orientation,1..size_max,
    [
      0,1,2,2,  %O11
      0,0,1,1,  %O12
      1,0,0,0,  %O13
      0,0,0,0,
      0,0,0,0,
      0,0,0,0,
    
      1,2,3,0,  %O21
      0,1,1,2,  %O22
      1,1,1,0,  %O23
      0,0,1,2,  %O24
      1,0,0,0,  %O25
      3,0,1,2,  %O26
    
      1,0,0,1,  %O31
      0,1,2,0,  %O32
      1,0,1,2,  %O33
      0,1,0,0,  %O34
      2,0,1,2,  %O35
      0,1,0,0,  %O36
    
      1,2,0,1,  %O41
      1,2,0,2,  %O42
      0,1,1,1,  %O43
      1,1,0,1,  %O44
      0,2,0,1,  %O45
      1,0,1,2,  %O46
    
      0,1,0,1,  %O51
      1,2,0,1,  %O52
      1,0,1,1,  %O53
      0,0,0,0,
      0,0,0,0,
      0,0,0,0,
    
      1,2,0,0,  %O61
      0,1,1,1,  %O62
      0,0,0,0,  %O63
      2,0,1,1,  %O64
      0,0,1,1,  %O65
      1,0,1,1,  %O66
    
      1,0,1,2,  %O71
      0,1,0,1,  %O72
      1,0,1,0,  %O73
      0,1,2,1,  %O74
      0,0,0,1,  %O75
      2,0,1,1   %O76
    ]);
    
% Formes des pièces en hauteur 
array[1..N,1..n_orientation,1..size_max] of int: my =
  array3d(1..N,1..n_orientation,1..size_max,
    [
      0,0,0,0,  %O11
      0,1,2,2,  %O12
      0,1,2,2,  %O13
      0,0,0,0,
      0,0,0,0,
      0,0,0,0,
    
      0,0,0,1,  %O21
      0,0,1,2,  %O22
      0,1,2,3,  %O23
      0,1,2,2,  %O24
      0,1,2,3,  %O25
      0,1,1,1,  %O26
    
      0,1,2,2,  %O31
      0,0,0,1,  %O32
      0,1,1,2,  %O33
      0,0,1,2,  %O34
      0,1,1,1,  %O35
      0,0,1,2,  %O36
    
      0,0,1,2,  %O41
      0,0,1,1,  %O42
      0,0,1,2,  %O43
      0,1,2,2,  %O44
      0,0,1,1,  %O45
      0,1,2,2,  %O46
    
      0,0,1,1,  %O51
      0,0,1,1,  %O52
      0,1,1,2,  %O53
      0,0,0,0,
      0,0,0,0,
      0,0,0,0,
    
      0,0,1,1,  %O61
      0,0,1,1,  %O62
      0,1,2,2,  %O63
      0,1,1,1,  %O64
      0,1,1,1,  %O65
      0,1,2,2,  %O66
    
      0,1,1,1,  %O71
      0,0,1,2,  %O72
      0,1,1,2,  %O73
      0,0,0,1,  %O74
      0,1,2,2,  %O75
      0,1,1,2   %O76
    ]);

% Variables des orientations des pièces
array[1..N, 1..n_orientation] of var 0..1: my_var_oe;
array[1..N, 1..n_orientation] of var 0..1: my_var_ou;

% Variables des positions des pièces
array[1..N] of var 1..27: my_var_ref;
array[1..N, 1..size_max] of var 1..27: my_var_index; % Index des de chaque morceau des pièces

% Variables représentant les couleurs pour chaque emplacement du plateau
array[1..27] of var int: plateau;

% Contrainte : l'index de tous les morceaux d'une pièce
% Pair
constraint forall(i in 1..N, o in 1..n_orientation, m in 1..size_max)(
    my_var_ref[i] + mxe[i, o, m] + 7*my[i, o, m] >= (my_var_oe[i, o]-1)*27 + my_var_index[i, m]
  );
constraint forall(i in 1..N, o in 1..n_orientation, m in 1..size_max)(
    my_var_ref[i] + mxe[i, o, m] + 7*my[i, o, m] <= (1-my_var_oe[i, o])*27 + my_var_index[i, m]
  );
% Impair
constraint forall(i in 1..N, o in 1..n_orientation, m in 1..size_max)(
    my_var_ref[i] + mxu[i, o, m] + 7*my[i, o, m] >= (my_var_ou[i, o]-1)*27 + my_var_index[i, m]
  );
constraint forall(i in 1..N, o in 1..n_orientation, m in 1..size_max)(
    my_var_ref[i] + mxu[i, o, m] + 7*my[i, o, m] <= (1-my_var_ou[i, o])*27 + my_var_index[i, m]
  );
/*
% Pair
constraint forall(i in 1..N, o in 1..n_orientation, m in 1..size_max)(
    my_var_oe[i, o] == 1 -> my_var_ref[i] + mxe[i, o, m] + 7*my[i, o, m] == my_var_index[i, m]
  );
% Impair
constraint forall(i in 1..N, o in 1..n_orientation, m in 1..size_max)(
    my_var_ou[i, o] == 1 -> my_var_ref[i] + mxu[i, o, m] + 7*my[i, o, m] == my_var_index[i, m]
  );
*/

% Contrainte : stocker les couleurs sur les cases du plateau
constraint forall(i in 1..N, m in 1..size_max, ind in 1..27)(
    plateau[ind] <= i + 27*abs(my_var_index[i,m]-ind)
  );
constraint forall(i in 1..N, m in 1..size_max, ind in 1..27)(
    plateau[ind] >= i - (27-i)*abs(my_var_index[i,m]-ind)
  );

% Contrainte : une seule orientation par pièce
constraint forall (i in 1..N)(
    1 == sum(o in 1..n_orientation) (my_var_oe[i,o] + my_var_ou[i,o])
  );

constraint 0 == sum(o in 4..n_orientation) (my_var_oe[1,o] + my_var_ou[1,o] + my_var_oe[5,o] + my_var_ou[5,o]);
constraint my_var_oe[2,3] + my_var_oe[2,5] == 0;

% Contrainte : les pièces ne sortent pas du plateau
constraint forall(i in 1..N)(
    my_var_ref[i] >= 1
  );
constraint forall(i in 1..N, m in 1..size_max)(
    my_var_index[i, m]  <= 27
  );
  
% Contrainte : les pièces ne doivent pas dépasser sur la droite du plateau
% Pair
constraint forall(i in 1..N, o in 1..n_orientation)(
    (my_var_ref[i]-1) mod 7 + my_var_oe[i, o] * widths_e[i, o] <= 7
  );
% Impair
constraint forall(i in 1..N, o in 1..n_orientation)(
    (my_var_ref[i]-1) mod 7 + my_var_ou[i, o] * widths_u[i, o] <= 7
  );

% Contrainte : les coordonnées (2,7) sont interdites
constraint forall(i in 1..N, m in 1..size_max)(
    my_var_index[i, m] != 14
  );

% Contrainte : les pièces ne doivent pas se superposer
constraint forall(i in 1..N, mi in 1..size_max, j in (i+1)..N, mj in 1..size_max)(
    my_var_index[i, mi] != my_var_index[j, mj]
  );
  
% Contrainte : les orientations impaires sur les hauteurs impaires (et l'inverse)
% Pair
constraint forall(i in 1..N, o in 1..n_orientation)(
    (my_var_ref[i]-1) mod 14 >= 7 - 7*(1-my_var_oe[i,o])
  );
% Impair
constraint forall(i in 1..N, o in 1..n_orientation)(
    (my_var_ref[i]-1) mod 14 <= 6 + 7*(1-my_var_ou[i,o])
  );
  
% Instance (Wizard 109)
constraint plateau[4] == 1;  constraint plateau[23] == 3;  constraint plateau[26] == 7;

% Instance (Wizard 110)
%  constraint plateau[10] == 1;  constraint plateau[18] == 7;

% Instance (Wizard 111)
%  constraint plateau[1] == 1;  constraint plateau[27] == 3;

% Instance (Wizard 112)
%  constraint plateau[8] == 7;  constraint plateau[13] == 1;

% Instance (Wizard 113)
%  constraint plateau[10] == 6;  constraint plateau[11] == 3;

% Instance (Wizard 114)
%  constraint plateau[3] == 3;  constraint plateau[5] == 5;  constraint plateau[7] == 7;

% Instance (Wizard 115)
%  constraint plateau[6] == 3;  constraint plateau[10] == 7;  constraint plateau[26] == 1;

% Instance (Wizard 116)
%  constraint plateau[5] == 5;  constraint plateau[16] == 1;

% Instance (Wizard 117)
%  constraint plateau[17] == 3;  constraint plateau[24] == 1;

% Instance (Wizard 118)
%  constraint plateau[18] == 3;  constraint plateau[20] == 6;

% Instance (Wizard 119)
%  constraint plateau[4] == 5;  constraint plateau[24] == 3;

% Instance (Wizard 120)
% constraint plateau[3] == 3;  constraint plateau[5] == 6;

% Instance (New)
% constraint plateau[1] == 2;

solve satisfy;

output
  ["\(plateau[1]) \(plateau[2]) \(plateau[3]) \(plateau[4]) \(plateau[5]) \(plateau[6]) \(plateau[7])\n",
   " \(plateau[8]) \(plateau[9]) \(plateau[10]) \(plateau[11]) \(plateau[12]) \(plateau[13])\n",
   "\(plateau[15]) \(plateau[16]) \(plateau[17]) \(plateau[18]) \(plateau[19]) \(plateau[20]) \(plateau[21])\n",
   " \(plateau[22]) \(plateau[23]) \(plateau[24]) \(plateau[25]) \(plateau[26]) \(plateau[27])\n"
  ];