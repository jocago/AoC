
import Foundation

struct p2021_2: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2021_2.parseToStringArray()
    var runPart = 2

    func part1() -> Any {
        var depth = 0
        var dist = 0
        
        for instruction in data {
            let ins = instruction.split(separator: " ")
            switch ins[0] {
            case "forward":
                dist += Int(ins[1])!
            case "down":
                depth += Int(ins[1])!
            case "up":
                depth -= Int(ins[1])!
            default:
                print("Found unhandled instruction")
            }
            if depth < 0 {
                depth = 0
            }
        }
        return depth * dist
    }

    func part2() -> Any {
        var depth = 0
        var dist = 0
        var aim = 0
        
        for instruction in data {
            let ins = instruction.split(separator: " ")
            switch ins[0] {
            case "forward":
                dist += Int(ins[1])!
                depth += aim * Int(ins[1])!
            case "down":
                aim += Int(ins[1])!
            case "up":
                aim -= Int(ins[1])!
            default:
                print("Found unhandled instruction")
            }
            if depth < 0 {
                depth = 0
            }
        }
        return depth * dist    }
}


fileprivate let testInput = Data(raw: """
forward 5
down 5
forward 8
up 3
down 8
forward 2
""")

