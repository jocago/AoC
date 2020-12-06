//
//  2020_06.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/5/20.
//

import Foundation
import SwifterSwift

/**
 Once again, speeding to the finish does *two* things:
 1) Makes the code inelegant
 2) Makes the code error prone
 3) Takes more time in the long run because it's buggy and harder to read
 */

struct p2020_6: Puzzle {
    //var data = testInput
    var data = input_2020_06
    var runPart = 2

    func part1() -> Any {
        var counts = 0
        for group in data.parseToFlattenedStringArray() {
            var ans = group.charactersArray
            counts += ans.removeDuplicates().count
        }
        
        return counts
    }

    func part2() -> Any {
        var counts = 0
        for group in data.parseToDeepStringArray() {
            var allAnsYes: [String] = []
            for person in group {
                let ans = person.charactersArray
                for a in ans {
                    if !allAnsYes.contains(String(a)) {
                        allAnsYes.append(String(a))
                    }
                }
            }
            for person in group {
                let ans = person.charactersArray
                for y in allAnsYes {
                    if !ans.contains(Character(y)) {
                        allAnsYes.removeAll(y)
                    }
                }
                
            }
            counts += allAnsYes.count
        }
        return counts
    }
}


fileprivate let testInput = Data(raw: """
abc

a
b
c

ab
ac

a
a
a
a

b
""")
