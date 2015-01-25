% The size of the board
int: N;

% The initial state of the board 0 = on 1 = off
array[int, int] of int: start;

% Decision of if we should flip the state of the light
array[1..N,1..N] of var 0..1: flip;

% Ensure that all the center lights are off
constraint forall (i, j in 2..(N-1)) (
  (start[i, j] + flip[i, j] +
   flip[i-1, j] + flip[i+1, j] +
   flip[i, j-1] + flip[i, j+1]) mod 2 = 0
);

% Ensure that the top lights are off
constraint forall (j in 2..(N-1)) (
  (start[1, j] + flip[1, j] +
   flip[2, j] +
   flip[1, j-1] + flip[1, j+1]) mod 2 = 0
);

% Ensure that the bottom lights are off
constraint forall (j in 2..(N-1)) (
  (start[N, j] + flip[N, j] +
   flip[N-1, j] +
   flip[N, j-1] + flip[N, j+1]) mod 2 = 0
);

% Ensure that the bottom lights are off
constraint forall (j in 2..(N-1)) (
  (start[N, j] + flip[N, j] +
   flip[N-1, j] +
   flip[N, j-1] + flip[N, j+1]) mod 2 = 0
);

% Ensure that the left lights are off
constraint forall (i in 2..(N-1)) (
  (start[i, 1] + flip[i, 1] +
   flip[i, 2] +
   flip[i-1, 1] + flip[i+1, 1]) mod 2 = 0
);

% Ensure that the right lights are off
constraint forall (i in 2..(N-1)) (
  (start[i, N] + flip[i, N] +
   flip[i, N-1] +
   flip[i-1, N] + flip[i+1, N]) mod 2 = 0
);

% Ensure that the corners are off
constraint (start[1, 1] + flip[1, 1] + flip[2, 1] + flip[1, 2]) mod 2 = 0;
constraint (start[N, 1] + flip[N, 1] + flip[N-1, 1] + flip[N, 2]) mod 2 = 0;
constraint (start[1, N] + flip[1, N] + flip[2, N] + flip[1, N-1]) mod 2 = 0;
constraint (start[N, N] + flip[N, N] + flip[N-1, N] + flip[N, N-1]) mod 2 = 0;

solve satisfy;

% Print out the lights we need to switch
output [ if fix(flip[i, j]) = 1 then "F" else "." endif ++
         if j=N then "\n" else "" endif |
         i,j in 1..N]
