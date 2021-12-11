
import Foundation

struct p2021_6: Puzzle {
    //var data = testInput.parseToIntArray(splitBy: ",")
    var data = input_2021_6.parseToIntArray(splitBy: ",")
    var runPart = 2
    
    func fishery(_ school:[Int], days: Int) -> Int {
        var ages = Array.init(repeating: 0, count: 9)
        // school's in session
        for fish in school {
            ages[fish] += 1
        }
        // now go until school's out for the summer
        for _ in 1...days {
            //print(ages)
            let spawn = ages[0]
            ages.removeFirst()
            ages.append(0)
            ages[8] += spawn
            ages[6] += spawn
        }
        return ages.sum()
    }

    func part1() -> Any {
        return fishery(data, days: 80)
    }

    func part2() -> Any {
        return fishery(data, days: 256)
    }
}


/*
 Pt 1 test target: 5934
 pt 2 test target: 26984457539
 */
fileprivate let testInput = Data(raw: """
3,4,3,1,2
""")


