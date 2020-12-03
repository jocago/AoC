//
//  2020_01.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/1/20.
//


import Foundation

struct p2020_1: Puzzle {
    var data: [Int] = input_2020_01.parseToIntArray()
    var verbose = false
    var runPart = 2
    let target = 2020

    func part1() -> Any {
        for i in 0..<data.count {
            for j in 0..<data.count {
                if data[i] + data[j] == target { return data[i] * data[j] }
            }
        }
        return -1
    }

    func part2() -> Any {
        for i in 0..<data.count {
            for j in 0..<data.count {
                for k in 0..<data.count {
                    if data[i] + data[j] + data[k] == target { return data[i] * data[j] * data[k] }
                }
            }
        }
        return -1

    }
}


fileprivate let testInput = Data(raw: """
1721
979
366
299
675
1456
""")

