//
//  Puzzle.swift
//  AoC
//
//  Created by Joshua Gohlke on 11/15/20.
//

import Foundation

protocol Puzzle {
    /**
     Puzzle must contain *runPart* with an int value of 1 or 2. This declares which part of the puzzle to run.
     It must also implement *part1()* and *part2()*. Both should return **something** to be printed, probably an int.
     */
    var runPart: Int { get set }
    func part1() -> Any
    func part2() -> Any
}

extension Puzzle {
    func run() {
        switch runPart {
        case 1:
            print(part1())
        case 2:
            print(part2())
        default:
            print("Puzzle not configured")
        }
    }
}
