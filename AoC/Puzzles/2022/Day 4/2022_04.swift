
import Foundation

struct p2022_4: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2022_4.parseToStringArray()
    var runPart = 2
    
    func getPairs() -> [(left: ClosedRange<Int>, right: ClosedRange<Int>)] {
        var pairs: [(left: ClosedRange<Int>, right: ClosedRange<Int>)] = []
        data.forEach { row in
            let pair = row.split(separator: ",")
            let leftSide = pair[0].split(separator: "-").map { Int($0)! }
            let rightSide = pair[1].split(separator: "-").map { Int($0)! }
            let leftRange = leftSide[0]...leftSide[1]
            let rightRange = rightSide[0]...rightSide[1]
            pairs.append((left: leftRange, right: rightRange))
        }
        return pairs
    }

    func part1() -> Any {
        var fullyOverlapped = 0
        for pair in getPairs() {
            if pair.left.lowerBound <= pair.right.lowerBound &&
                pair.left.upperBound >= pair.right.upperBound {
                fullyOverlapped += 1
            } else if pair.right.lowerBound <= pair.left.lowerBound &&
                        pair.right.upperBound >= pair.left.upperBound {
                fullyOverlapped += 1
            }
        }
        return fullyOverlapped
    }

    func part2() -> Any {
        var overlapped = 0
        for pair in getPairs() {
            if pair.left.overlaps(pair.right) { overlapped += 1 }
        }
        return overlapped
    }
}


/*
 Pt 1 test target: 2
 pt 2 test target: 4
 */
fileprivate let testInput = Data(raw: """
2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8
""")


