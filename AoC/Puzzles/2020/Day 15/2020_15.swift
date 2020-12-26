//
//  2020_15.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/21/20.
//


import Foundation

struct p2020_15: Puzzle {
//    var data = testInput.parseToIntArray(splitBy: ",")
    var data = input_2020_15.parseToIntArray(splitBy: ",")
    var runPart = 2
    
    func memGame(target: Int) -> Int {
        var nums: [Int: Int] = [:]
        var num = data.last!
        for i in 0..<data.count {
            nums[data[i]] = i
        }
        for i in data.count ..< target  {
            let i = i - 1
            if let index = nums[num] {
                nums[num] = i
                num = i - index
            } else {
                nums[num] = i
                num = 0
            }
        }
        return num
    }
    
    func part1() -> Any {
        return memGame(target: 2020)
    }

    func part2() -> Any {
        return memGame(target: 30000000)
    }
}


fileprivate let testInput = Data(raw: "3,1,2") // 1836



