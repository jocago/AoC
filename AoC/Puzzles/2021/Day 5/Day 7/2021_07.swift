
import Foundation

struct p2021_7: Puzzle {
    //var data = testInput.parseToIntArray(splitBy: ",")
    var data = input_2021_7.parseToIntArray(splitBy: ",")
    var runPart = 2
    
    enum CalcMethod {
        case linear, progressive
    }
    
    func fuel(crabbies: [Int], method: CalcMethod) -> Int {
        let fuelSlots = (crabbies.min()!...crabbies.max()!).map { gotoCrabbie in
            crabbies
                .map { crabbie in
                    let diff = abs(crabbie - gotoCrabbie)
                    switch method {
                    case .linear:
                        return diff
                    case .progressive:
                        return (diff * (diff + 1)) / 2
                    }
                }
                .reduce(0, +)
        }
        return fuelSlots.min()!
    }
    
    

    func part1() -> Any {
        return fuel(crabbies: data, method: .linear)
    }

    func part2() -> Any {
        return fuel(crabbies: data, method: .progressive)
    }
}



/*
 Pt 1 test target: 37
 pt 2 test target: 168
 */
fileprivate let testInput = Data(raw: """
16,1,2,0,4,2,7,1,2,14
""")


