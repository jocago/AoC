#  Advent of Code

A multi-year code base for completing AoC challenges. This started in 2020. 

The main.swift file is the entry point into the command line project and basically points to the current puzzle and runs it. 

## Internal components

### Base

This contains the main puzzle components. 

- Input -- Deals with the data provided by the AoC website. Most of the basic functions for getting the data and parsing it into arrays should be here.
- Puzzle -- A daily puzzle should conform to the Puzzle protocol so that it can be run by main. This protocol contains the run method that is executed by main.
    
### Structures

New data structures needed to complete challenges. 

- Tree -- A basic tree structure that echos back to the 2019 challenge.

## External Components

These are packages linked to the project which may be useful for problem solving. 

### Swift Algorithms

While I have not used this package in the project yet, it may proove helpful.

https://github.com/apple/swift-algorithms

### Swift Numerics

While I have not used this package in the project yet, it may proove helpful.

https://github.com/apple/swift-numerics

### SwifterSwift

I've used the following components

- StringExtensions -> charactersArray

https://github.com/SwifterSwift/SwifterSwift

### SwiftGraph

While I have not used this package in the project yet, it may proove helpful.

https://davecom.github.io/SwiftGraph

## Other sources

These are places from which I've gotten specific algos or structures. 

### Swift Algorithm Club

This has been a great resource for many additions to my libs while I've been learning Swift.

https://github.com/raywenderlich/swift-algorithm-club

