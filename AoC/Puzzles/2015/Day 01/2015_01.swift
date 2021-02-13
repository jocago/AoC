//
//  2015_01.swift
//  AoC
//
//  Created by Joshua Gohlke on 2/13/21.
//

import Foundation

struct p2015_01: Puzzle {
    //var data = testInput.raw
    //var data = testInput2.raw
    var data = input_2015_01.raw
    var runPart = 2

    func part1() -> Any {
                
        return data.filter { $0 == "(" }.count - data.filter { $0 == ")" }.count
    }

    func part2() -> Any {
        var floorNum = 0
        let floors = data.charactersArray
        for i in 0..<floors.count {
            switch floors[i] {
            case "(":
                floorNum += 1
            case ")":
                floorNum -= 1
            default:
                ()
            }
            if floorNum < 0 {
                return i + 1
            }
        }
        return -1
    }
}


fileprivate let testInput = Data(raw: """
)())())
""") // -3

fileprivate let testInput2 = Data(raw: """
()())
""") // 5
