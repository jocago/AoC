//
//  2020_10.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/10/20.
//


import Foundation

struct p2020_10: Puzzle {
    //var data = testInput.parseToIntArray()
    var data = input_2020_10.parseToIntArray()
    var runPart = 2

    func part1() -> Any {
        var gaps: [Int: Int] = [0:0,1:0,2:0,3:0,-1:0]
        var jolts = data.sorted()
        jolts.append(jolts.max()! + 3)
        jolts.insert(0, at: 0)
        for i in 1..<jolts.count {
            let diff = jolts[i] - jolts[i - 1]
            switch diff {
            case 0...3:
                gaps[diff]! += 1
            default:
                gaps[-1]! += 1
            }        }
        print(gaps)
        return gaps[1]! * gaps[3]!
    }

    func part2() -> Any {
        
        let jolts = data.sorted()
        
        var memo = [0:1] // I learned about memoization!
        for i in jolts {
            var cnt = 0
            for j in (1...3) {
                cnt += memo[i - j] ?? 0
                memo[i] = cnt
            }
        }
        
        return memo[jolts.last!]!
    }
}

fileprivate let testInput = Data(raw: """
28
33
18
42
31
14
46
20
48
47
24
23
49
45
19
38
39
11
1
32
25
35
8
17
7
9
4
2
34
10
3
""")


