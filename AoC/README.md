#  Advent of Code

This is the project for my AoC work. While Python has been my language of choice for over a decade, I want to complete the challenge using Swift. 

The structure oof the project may be a little unorthodox. 

The main.swift file should call the puzzle's main structure and then call run from there. 

The Puzzle protocol enforces conformity to the run() method. As well, there is an Input protocol and enforces a raw datatype and a Data struct that provides some basic parsing capabilites for the data. 

In general, my expectation is to include the puzzle input as a Data object in the file for the puzzle. That is to take advantage of the file scope. I also expect to include the instructions for the puzzle just for ease of reference. 

And this will all probably change drastically as I actually use it. 

## Components:

- Base
    - Input
        - Input: Protocol
        - Data: Struct
    - Puzzle:
        - Puzzle: Protocol
