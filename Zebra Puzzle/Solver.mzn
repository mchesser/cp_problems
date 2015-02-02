include "alldifferent.mzn";

% 1. There are five houses
int: numHouses = 5;

% People
var 1..numHouses: englishman;
var 1..numHouses: spaniard;
var 1..numHouses: ukrainian;
var 1..numHouses: norwegian;
var 1..numHouses: japanese;
array[1..numHouses] of var 1..numHouses: people = [englishman, spaniard, ukrainian, norwegian, japanese];
constraint alldifferent(people);

% Paint colors
var 1..numHouses: red;
var 1..numHouses: green;
var 1..numHouses: ivory;
var 1..numHouses: yellow;
var 1..numHouses: blue;
constraint alldifferent([red, green, ivory, yellow, blue]);

% Pets
var 1..numHouses: dog;
var 1..numHouses: snails;
var 1..numHouses: fox;
var 1..numHouses: horse;
var 1..numHouses: zebra;

constraint alldifferent([dog, snails, fox, horse, zebra]);

% Drinks
var 1..numHouses: coffee;
var 1..numHouses: tea;
var 1..numHouses: milk;
var 1..numHouses: orangeJuice;
var 1..numHouses: water;
constraint alldifferent([coffee, tea, milk, orangeJuice, water]);

% Cigaret brands
var 1..numHouses: oldGold;
var 1..numHouses: kools;
var 1..numHouses: chesterfields;
var 1..numHouses: luckyStrike;
var 1..numHouses: parliaments;
constraint alldifferent([oldGold, kools, chesterfields, luckyStrike, parliaments]);

constraint englishman = red;            % 2.  Englishman lives in the red house
constraint spaniard = dog;              % 3.  The Spaniard owns a dog
constraint coffee = green;              % 4.  Coffee is drunk in the green house.
constraint ukrainian = tea;             % 5.  The Ukrainian drinks tea.
constraint green = ivory + 1;           % 6.  The green house is immediately to the right of the ivory house.
constraint oldGold = snails;            % 7.  The Old Gold smoker owns snails.
constraint kools = yellow;              % 8.  Kools are smoked in the yellow house.
constraint milk = 3;                    % 9.  Milk is drunk in the middle house.
constraint norwegian = 1;               % 10. The Norwegian lives in the first house.
constraint chesterfields = fox + 1 \/   % 11. The man who smokes Chesterfields lives in the house next to the man with the fox.
           chesterfields = fox - 1;
constraint kools = horse + 1 \/         % 12. Kools are smoked in the house next to the house where the horse is kept.
           kools = horse - 1;
constraint luckyStrike = orangeJuice;   % 13. The Lucky Strike smoker drinks orange juice.
constraint japanese = parliaments;      % 14. The Japanese smokes Parliaments.
constraint norwegian = blue + 1 \/      % 15. The Norwegian lives next to the blue house.
           norwegian = blue - 1;

% Determine who owns the zebra
var 1..numHouses: zebraOwner;
constraint forall (i in 1..numHouses where people[i] = zebra)(zebraOwner = i);

% Determine who drinks water
var 1..numHouses: waterDrinker;
constraint forall (i in 1..numHouses where people[i] = water)(waterDrinker = i);

solve satisfy;

array[1..numHouses] of string: peopleNames = ["Englishman", "Spaniard", "Ukrainian", "Norwegian", "Japanese"];
output ["The " ++ show(peopleNames[zebraOwner]) ++ " owns a Zebra, " ++
        "The " ++ show(peopleNames[waterDrinker]) ++ " drinks water."];
