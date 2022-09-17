A 42 (school) project in which, given a map filled with obstacles you have to find the biggest square that fits within the empty tiles of the map.

How to run
Using a terminal from within the BSQ folder:

create the executable by using the Makefile (run the command "make")
generate a map filled with obstacles using the "mapGenerator" perl program (running the command "perl mapGenerator 18 18 9 > map" will generate a map that's 18x18 in size with an obstacle density of 9 and save it in a file called "map"). Note: maps generated with this generator use the following legend:
'.' - empty tile
'o' - obstacle
'x' - square tile
run the command "./bsq map"