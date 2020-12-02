
import Foundation

struct p2020_x: Puzzle {
    var data = testInput.parseToIntArray()
    var verbose = false
    var runPart = 0
    
    func run() {
        switch runPart {
        case 1:
            print(part1())
        case 2:
            print(part2())
        default:
            print("Puzzle not configured")
        }
    }

    func part1() -> Int {
        return 0
    }

    func part2() -> Int {
        return 0
    }
}


fileprivate let testInput = Data(raw: """

""")

fileprivate let input = Data(raw: """

""")
