//
//  2020_14.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/18/20.
//


import Foundation
import SwifterSwift

// This was painful. I worked and reworked the masking only to find out I set my string
// slicing index wrong by one char length. Check your assumptions.

struct p2020_14: Puzzle {
    //var data = testInput.parseToStringArray()
    //var data = testInput2.parseToStringArray()
    var data = input_2020_14.parseToStringArray()
    var runPart = 2
    
    func maskAddr(addr: [Character], mask: [Character], i: Int = 0) -> [[Character]] {
        guard addr.count == 36 else {fatalError("addr is wrong length: \(addr.count)")}
        guard mask.count == 36 else {fatalError("mask is wrong length: \(mask.count)")}
        guard i < 36 else { return [addr] } // recursion done
        var resp: [[Character]] = []
        switch mask[i] {
        case "1":
            var a = addr
            a[i] = "1"
            //print("\(i) - sending 1: \(String(a))")
            let _ = maskAddr(addr: a, mask: mask, i: i + 1).map {resp.append($0)}
            //print("\(i) - now: \(resp.map {String($0)})")
            return resp
        case "X":
            var a = addr
            var b = addr
            a[i] = "1"
            //print("\(i) - sending X1: \(String(a))")
            let _ = maskAddr(addr: a, mask: mask, i: i + 1).map {resp.append($0)}
            b[i] = "0"
            //print("\(i) - sending X0: \(String(b))")
            let _ = maskAddr(addr: b, mask: mask, i: i + 1).map {resp.append($0)}
            //print("\(i) - now: \(resp.map {String($0)})")
            return resp
        default:
            let _ = maskAddr(addr: addr, mask: mask, i: i + 1).map {resp.append($0)}
            return resp
            
        }
    }

    func part1() -> Any {
        var mask: [Character] = []
        var bank: [String: String] = [:]
        for instr in data.map({ $0.components(separatedBy: " = ") }) {
            if instr[0] == "mask" { mask = instr[1].charactersArray }
            else {
                var value: [Character] = String(Int(instr[1])!, radix: 2)
                    .paddingStart(36, with: "0")
                    .charactersArray
                for i in 0..<mask.count {
                    if mask[i] != "X" { value[i] = mask[i] }
                }
                bank[instr[0]] = String(value)
            }
        }
        var ret = 0
        for addr in bank {
            ret += Int(addr.value, radix: 2)!
        }
        return ret
    }

    func part2() -> Any {
        var mask: [Character] = []
        var bank: [Int: Int] = [:]
        for instr in data.map({ $0.components(separatedBy: " = ") }) {              // for each instr
            if instr[0] == "mask" { mask = instr[1].charactersArray }               // set the mask or
            else {                                                                  // fudge the addr
                let idxS = instr[0].index(instr[0].startIndex, offsetBy: 4)
                let idxE = instr[0].index(instr[0].endIndex, offsetBy: -1)
                let mem = instr[0][idxS..<idxE]
                let addr: [Character] = String(Int(mem)!, radix: 2)
                    .paddingStart(36, with: "0")
                    .charactersArray
                let value = Int(instr[1])
                //print("starting mem: \(String(addr))")
                let _ = maskAddr(addr: addr, mask: mask).map { bank[Int(String($0),radix: 2)!] = value }
            }
        }
        return bank.map({$0.value}).reduce(0, +)
    }
}


fileprivate let testInput = Data(raw: """
mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X
mem[8] = 11
mem[7] = 101
mem[8] = 0
""")

fileprivate let testInput2 = Data(raw: """
mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1
""")
