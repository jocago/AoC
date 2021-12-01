
import Foundation

struct p2021_1: Puzzle {
    //var data = testInput.parseToIntArray()
    var data = input_2021_01.parseToIntArray()
    var runPart = 2
    
    func countUpDown(arr: [Int]) -> Int {
        var up = 0
        var down = 0
        var prevs = -1
        for val in arr {
            if prevs >= 0 {
                if val < prevs {
                    down += 1
                } else if val > prevs {
                    up += 1
                }
            }
            prevs = val
        }
        return up
    }
    
    func part1() -> Any {
        return countUpDown(arr: data)
    }

    func part2() -> Any {
        var grp: [Int] = []
        
        for i in 2..<data.count {
            grp.append(data[i - 2] + data[i - 1] + data[i])
        }
        return countUpDown(arr: grp)
    }
}


fileprivate let testInput = Data(raw: """
199
200
208
210
200
207
240
269
260
263
""")
