
import Foundation

struct p2022_6: Puzzle {
    //var data = testInput.raw.charactersArray
    var data = input_2022_6.raw.charactersArray
    var runPart = 2
    
    func detect_size(of target: Int) -> Int {
        var i = target-1
        while i < data.count {
            if Set(data[(i-(target-1))...i]).count == target { return i+1}
            i += 1
        }
        return -1
    }

    func part1() -> Any {
        return detect_size(of: 4)
    }

    func part2() -> Any {
        return detect_size(of: 14)
    }
}


/*
 Pt 1 test target: 7
 pt 2 test target: ?
 */
fileprivate let testInput = Data(raw: """
mjqjpqmgbljsphdztnvjfqwrcgsmlb
""")


