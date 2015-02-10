include "alldifferent.mzn";

int: N;

% The location of the queen in each column
array[1..N] of var 1..N: queens;

constraint forall (i in 1..N, j in 1..N where i < j) (
  % Ensure that each queen occupies a different row
  queens[i] != queens[j]

  % Ensure that each queen occupies a different diagonal
  /\ queens[i] + i != queens[j] + j
  /\ queens[i] - i != queens[j] - j
);

solve satisfy;

output [if fix(queens[j])=i then "Q" else "." endif ++
        if j=N then "\n" else "" endif |
        i,j in 1..N]
