//
//  2015_04.swift
//  AoC
//
//  Created by Joshua Gohlke on 2/14/21.
//

import Foundation



struct p2015_04: Puzzle {
    //var data = testInput.raw
    var data = input_2015_04.raw
    var runPart = 2

    func findNumPadded(with pad: String, starting: Int = 1) -> Int {
        var inNum = starting
        while true {
            let s = data + String(inNum)
            if s.MD5.starts(with: pad) {
                return inNum
            } else {
                inNum += 1
            }
        }
    }
    
    func part1() -> Any {
        return findNumPadded(with: "00000")
    }

    func part2() -> Any {
        return findNumPadded(with: "000000", starting: 346386)
    }
}


fileprivate let testInput = Data(raw: """
pqrstuv
""")  //  1048970 / ???


