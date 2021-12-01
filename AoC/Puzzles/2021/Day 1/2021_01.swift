
import Foundation
import Algorithms

struct p2021_1: Puzzle {
    //var data = testInput.parseToIntArray()
    var data = input_2021_01.parseToIntArray()
    var runPart = 2
    
    func countUps(arr: Array<Int>) -> Int {
        arr.adjacentPairs().count(where: {$1 > $0})
    }
    
    
    func part1() -> Any {
        countUps(arr: data)
    }

    func part2() -> Any {
        let grp = data
                    .windows(ofCount: 3)
                    .map {$0.sum()}
        return countUps(arr: grp)
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
