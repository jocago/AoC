//
//  2015_02.swift
//  AoC
//
//  Created by Joshua Gohlke on 2/13/21.
//


import Foundation

struct p2015_02: Puzzle {
    //var data = testInput.parseToStringArray()
    //var data = testInput2.parseToStringArray()
    var data = input_2015_02.parseToStringArray()
    var runPart = 2
    
    func getDims(_ dims: String) -> [Int] {
        return dims.components(separatedBy: "x").map { Int($0)! }
    }
    
    func getPaperNeeded(_ dims: [Int]) -> Int {
        guard dims.count == 3 else { fatalError("Not valid dimensions \(dims)") }
        var surface: [Int] = []
        surface.append(dims[0] * dims[1])
        surface.append(dims[0] * dims[2])
        surface.append(dims[1] * dims[2])
        return (2 * surface.sum()) + surface.min()!
    }
    
    func getRibbonNeeded(_ dims: [Int]) -> Int {
        guard dims.count == 3 else { fatalError("Not valid dimensions \(dims)") }
        return 2 * dims.sorted()[0...1].sum() + dims.reduce(1, *)
    }

    func part1() -> Any {
        var paper = 0
        for box in data {
            paper += getPaperNeeded(getDims(box))
        }
        return paper
    }

    func part2() -> Any {
        var ribbon = 0
        for box in data {
            ribbon += getRibbonNeeded(getDims(box))
        }
        return ribbon
    }
}


fileprivate let testInput = Data(raw: """
2x3x4
1x1x10
""")  // 101 / 48

fileprivate let testInput2 = Data(raw: """
3x4x2
1x10x1
""")  // 101 / 48

