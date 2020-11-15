//
//  2019_02.swift
//  AoC
//
//  Created by Joshua Gohlke on 11/15/20.
//

import Foundation

struct p2019_02 {
    /*
     It's super frustrating that I can't conform to the Puzzle protocol. But I'm changing something in the intcode computer's memory which cascades mutation all the way back to this struct which then does not conform because run() can't be mutating. This seems overly complicated.
     */
    
    var data = input.parseToIntArray(splitBy: ",")
    lazy var computer = IntcodeComputer(memory: data)
    
    mutating func run() {
        part1()
        part2()
    }
    
    mutating func part1() {
        computer.memory[1] = 12
        computer.memory[2] = 2
        do {
            try computer.exec()
        } catch IntcodeError.unknownOpcode {
            print("The opcode is whack!")
        } catch { print("Some error happened")}
        print(computer.memory[0])
    }
    
    mutating func part2() {
        let target = 19690720 // The target answer for when we can derrive our response
        var solved = false
        for i in 0...99 {
            for j in 0...99 {
                var computer = IntcodeComputer(memory: data) // State has to be reset each time
                computer.memory[1] = i  // New input value 1
                computer.memory[2] = j  // New input value 2
                do {
                    try computer.exec()
                } catch IntcodeError.unknownOpcode {
                    print("The opcode is whack!")
                } catch { print("Some error happened")}
                if computer.memory[0] == target {
                    print(100 * i + j)  // Derrived response when we have the right answer
                    solved = true
                }
            }
        }
        if !solved {
            print("Something didn't happen.") // If we hit this, we never hit our answer
        }
        
    }
}


fileprivate let input = Data(raw: """
1,0,0,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,9,19,1,5,19,23,1,6,23,27,1,27,10,31,1,31,5,35,2,10,35,39,1,9,39,43,1,43,5,47,1,47,6,51,2,51,6,55,1,13,55,59,2,6,59,63,1,63,5,67,2,10,67,71,1,9,71,75,1,75,13,79,1,10,79,83,2,83,13,87,1,87,6,91,1,5,91,95,2,95,9,99,1,5,99,103,1,103,6,107,2,107,13,111,1,111,10,115,2,10,115,119,1,9,119,123,1,123,9,127,1,13,127,131,2,10,131,135,1,135,5,139,1,2,139,143,1,143,5,0,99,2,0,14,0
""")
