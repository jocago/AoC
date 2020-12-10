//
//  2020_09.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/9/20.
//



import Foundation

struct p2020_9: Puzzle {
    //var data = testInput.parseToIntArray()
    var data = input_2020_9.parseToIntArray()
    var runPart = 2
    let preamble = 25
    
    struct Xmas {
        let preamble: Int
        var fifo: [Int] = [] { didSet { if fifo.count > preamble { fifo.removeFirst(fifo.count - preamble) } } }
        
        mutating func add(num: Int) { fifo.append(num) }
        
        func matchTo(num: Int) -> (i: Int, j: Int, iVal: Int, jVal: Int) {
            for i in 0..<fifo.count {
                for j in 0..<fifo.count {
                    if i != j {
                        if fifo[i] + fifo[j] == num {
                            return (i: i, j: j, iVal: fifo[i], jVal: fifo[j])
                        }
                    }
                }
            }
            return (i: -1, j: -1, iVal: -1, jVal: -1)
        }
        
        func isFifoReady() -> Bool {
            return fifo.count == preamble
        }
    }

    func getBreakNum() -> Int {
        var xmas = Xmas(preamble: preamble)
        for num in data {
            if xmas.isFifoReady() {
                let (_,_,iVal,jVal) = xmas.matchTo(num: num)
                if !(iVal + jVal == num) {
                    return num
                } else {
                    xmas.add(num: num)
                }
            } else { xmas.add(num: num) }
        }
        
        return -1
    }
    
    func part1() -> Any {
        return getBreakNum()
    }

    func part2() -> Any {
        let target = getBreakNum()
        for x in 2...data.count { // num contiguous elements to evaluate
            var low = 0
            var high: Int { return low + x }
            var sum = 0
            var min = Int.max
            var max = Int.min
            
            while high < data.count {
                sum = 0
                min = Int.max
                max = Int.min
                for i in low..<high {
                    sum += data[i]
                    data[i] < min ? min = data[i] : ()
                    data[i] > max ? max = data[i] : ()
                }
                if sum == target {
                    return min + max
                } else {
                    low += 1
                }
            }
        }
        return -1
    }
}


fileprivate let testInput = Data(raw: """
35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576
""")


