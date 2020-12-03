//
//  2020_03.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/2/20.
//

import Foundation
import SwifterSwift

struct p2020_3: Puzzle {
    var data: [String]
    var runPart = 2
    var charMap: [[Character]]
    
    
    init() {
        data = input_2020_03.parseToStringArray()
        charMap = data.map { String($0).charactersArray }
    }
    
    func getTreesHit(pattern: [Int]) -> Int {
        var treesEncountered = 0
        var x = 0
        var y = 0
        while true {
            x += pattern[0]
            y += pattern[1]
            if x >= charMap.count { break }
            if y >= charMap[0].count { y -= charMap[0].count }
            if charMap[x][y] == "#" { treesEncountered += 1 }
        }
        return treesEncountered
    }

    func part1() -> Any {
        let pattern = [1,3] // 1 down and 3 across
        return getTreesHit(pattern: pattern)
    }

    func part2() -> Any {
        let patterns = [
            [1,1],
            [1,3],
            [1,5],
            [1,7],
            [2,1]
        ]
        return patterns.map { getTreesHit(pattern: $0) }.reduce(1, *)
    }
}


fileprivate let testInput = Data(raw: """
..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#
""")
