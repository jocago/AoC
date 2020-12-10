//
//  2020_08.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/9/20.
//

import Foundation

struct p2020_8: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2020_08.parseToStringArray()
    var runPart = 2
    
    func parseInstruction(lineNum: Int, accumulator: Int, line: String) -> (Int,Int) {
        let instr = line.split(separator: " ")
        let action = instr[0]
        let param = Int(instr[1])!
        switch action {
        case "acc":
            return (lineNum + 1, accumulator + param)
        case "jmp":
            return (lineNum + param, accumulator)
        default: // nop
            return (lineNum + 1, accumulator)
        }
    }
    
    func part1() -> Any {
        var i = 0 // instruction to execute
        var a = 0 // accumulator
        var hist: [Int] = []
        while i < data.count {
            hist.append(i)
            (i,a) = parseInstruction(lineNum: i, accumulator: a, line: data[i])
            if hist.contains(i) { break }
        }
        return a
    }
    
    func part2() -> Any {
        // et tu, brute force?
        var i = 0 // instruction to execute
        var a = 0 // accumulator
        var hist: [Int] = []
        var errorFree = false
        var swapIdx = -1 // starting out assuming the existing instr set works
        while !errorFree {
            i = 0 // instruction to execute
            a = 0 // accumulator
            hist = []
            while i < data.count {
                errorFree = true // hopeful programming?
                hist.append(i)
                var dataIn = data[i]
                if swapIdx == i { // flip the instructions
                    if dataIn.contains("nop") {
                        dataIn = dataIn.replacingOccurrences(of: "nop", with: "jmp")
                    } else if dataIn.contains("jmp") {
                        dataIn = dataIn.replacingOccurrences(of: "jmp", with: "nop")
                    }
                }
                (i,a) = parseInstruction(lineNum: i, accumulator: a, line: dataIn)
                if hist.contains(i) {
                    errorFree = false
                    break
                }
            }
            if !errorFree {
                swapIdx += 1            }
        }
        return a
    }
}


fileprivate let testInput = Data(raw: """
nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6
""")
