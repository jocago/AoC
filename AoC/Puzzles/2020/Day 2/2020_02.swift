//
//  2020_02.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/2/20.
//

import Foundation
import SwifterSwift

struct p2020_2: Puzzle {    

    var data: [String] = input_2020_02.parseToStringArray()
    var runPart = 2

    func part1() -> Any {
        var passThatPasses = 0
        for row in data {
            let r = row.split(separator: " ")
            guard r.count == 3 else { return -1 } // -1 error - not splitting into 3 parts
            let range: [Int] = r[0].split(separator: "-").map { Int($0)! }
            let char: Character = Character(String(r[1].first!))
            let pw: String = String(r[2])
            
            let pwCharCount = pw.filter { $0 == char }.count
            if pwCharCount >= range[0] && pwCharCount <= range[1] { passThatPasses += 1 }
            
        }
        return passThatPasses
    }

    func part2() -> Any {
        var passThatPasses = 0
        for row in data {
            let r = row.split(separator: " ")
            guard r.count == 3 else { return -1 } // -1 error - not splitting into 3 parts
            let range: [Int] = r[0].split(separator: "-").map { Int($0)! }
            let char: Character = Character(String(r[1].first!))
            let pw: [Character] = String(r[2]).charactersArray
            
            let chA = pw[range[0] - 1]
            let chB = pw[range[1] - 1]
            if chA != chB && ( chA == char || chB == char) { passThatPasses += 1 }
        }
        return passThatPasses
    }
}


fileprivate let testInput = Data(raw: """
1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
""")

