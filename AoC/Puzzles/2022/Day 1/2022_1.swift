
import Foundation

struct p2022_1: Puzzle {
    //var data = testInput.parseToBlockOfStringsArray()
    var data = input_2022_1.parseToBlockOfStringsArray()
    var runPart = 2
    
    func get_packs() -> [Int] {
        var packs: [Int] = []
        for l in data {
            var x = 0
            for e in l {
                x +=  Int(e)!
            }
            packs.append(x)
        }
        return packs
    }

    func part1() -> Any {
        let packs = self.get_packs()
        return packs.max()!
    }

    func part2() -> Any {
        let packs = self.get_packs()
        var cals = 0
        for i in 0..<3 {
            cals += packs.sorted().reversed()[i]
        }
        return cals
    }
}


/*
 Pt 1 test target: ?
 pt 2 test target: ?
 */
fileprivate let testInput = Data(raw: """
1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
""")


