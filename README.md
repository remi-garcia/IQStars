# IQ Stars

IQ Stars is a puzzle for one player by SmartGames.
The game consists of a board and seven pieces of different shapes, the goal is to fit all the pieces inside the game board.
The set of pieces is such that when all the pieces fit in the puzzle, all the board’s cells are filled.
A challenge is a partial filling of the board where some cells are constrained to be filled by certain colors.
Each challenge allows one and only one solution.
A booklet with 120 challenges comes with the game.

The game board is composed of 26 empty cells and the pieces are composed of three or four stars, are unique and single-sided.
In general, we will refer to each piece by its color.

A difficulty of this puzzle is that the board is not a square nor are its cells.
We overcame that issue by enumerating all the possible positions for each piece, with that approach the shape of the board has no impact.
Using this method we were able to produce a list of all the possible fillings of a blank board and we proved that God challenges -- a starting position's puzzle with a single star -- do not exist.


### Solving it with CP

In order to solve IQ Stars we used MiniZinc, a constraints programming modeling tool, and Chuffed, an open-source CP solver.
Our model is composed of a single constraint thanks to a rich precomputation method.
To each cell on the board is associated a number from 1 to 26.
The upper left corner cell is 1 and then from left to right then up to bottom we number the cells until we reach the bottom right corner.

We enumerate all the possible positions of the game board each piece could be positioned at.
To do so, we arbitrarily choose a reference star for each piece and a reference rotation.
Then, for each piece and for each cell of the game board we check the six rotations.
If that leads to a valid position -- meaning that the piece is totally on the game board -- we store it.

This leads to seven arrays of positions, one for each piece.
For example, there is exactly 67 ways to put the pink piece on the board, in particular it can be placed on the positions { $1, 2, 9, 15$ } or { $2, 3, 10, 16$ }.

Having these arrays permits to formulate a single constraint with MiniZinc:
```MiniZinc
constraint {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,
                18,19,20,21,22,23,24,25,26} subset
    (positions_blue[piece_position[1]]
        union positions_green[piece_position[2]]
        union positions_yellow[piece_position[3]]
        union positions_red[piece_position[4]]
        union positions_pink[piece_position[5]]
        union positions_orange[piece_position[6]]
        union positions_purple[piece_position[7]]);
```
where `positions_color` correspond to the arrays of possible positions and `piece_position` is an array of seven variables.
The constraint ensures that the set of the $26$ cells is a subset of the cells covered by the union of the piece.
There cannot be any overlap on the pieces placing as it would lead to one, or more, empty cells on the board.

In order to solve a specific challenge one could add constraints on position that should be covered by a given piece.
For example the last challenge of the booklet can be solved by adding the constraints:
```MiniZinc
constraint 3 in positions_yellow[piece_position[3]];
constraint 5 in positions_orange[piece_position[6]];
```

If no constraints are added we can enumerate all the possible fillings of the game board.
This has been done and from the results we can see that God challenges do not exist: for every starting position with a single cell covered there exists multiple solutions.


### To run this code

```julia
using Pkg
Pkg.add("Images")
Pkg.add("ImageDraw")

include("src/iqstars.jl")
main()
