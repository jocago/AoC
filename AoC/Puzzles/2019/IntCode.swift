//
//  IntCode.swift
//  AoC
//
//  Created by Joshua Gohlke on 11/15/20.
//

import Foundation

enum IntcodeError: Error {
    case unknownOpcode(opcode: Int)
}

struct IntcodeComputer {
    var memory: [Int]
    var pointer: Int = 0
    
    mutating func exec() throws {
        var opcode = memory[pointer]
        
        while opcode != 99 {  // Halts execution
            switch opcode {
            case 1: // Adds in1 and in2 and stores value in out1
                let in1 = memory[pointer + 1]
                let in2 = memory[pointer + 2]
                let out1 = memory[pointer + 3]
                memory[out1] = memory[in1] + memory[in2]
                pointer += 4
            case 2: // Multiplies in1 and in2 and stores value in out1
                let in1 = memory[pointer + 1]
                let in2 = memory[pointer + 2]
                let out1 = memory[pointer + 3]
                memory[out1] = memory[in1] * memory[in2]
                pointer += 4
            default:
                throw IntcodeError.unknownOpcode(opcode: opcode)
            }
            opcode = memory[pointer]
        }
    }
}
