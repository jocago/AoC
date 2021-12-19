
import Foundation

fileprivate extension Int {
    var didFlash:Bool { self > 9 }
}

struct p2021_11: Puzzle {
    //var data = testInput.parseToStringArray().map { $0.charactersArray.map { Int(String($0))! } }
    var data = input_2021_11.parseToStringArray().map { $0.charactersArray.map { Int(String($0))! } }
    var runPart = 2
    
    func step(matrix: Matrix<Int>) -> (Matrix<Int>, Int) {
        var matrix = matrix
        var flashesCount = 0
        var queue:[Point] = []
        var flashedTracker:[Point] = []
        for x in 0..<matrix.width {
            for y in 0..<matrix.hight {
                queue.append(Point(x: x, y: y))
            }
        }
        while !queue.isEmpty {
            let point = queue.removeFirst()
            let val = matrix.getVal(at: point) + 1
            matrix.setVal(at: point, to: val)
            if val.didFlash && !flashedTracker.contains(point) {
                flashedTracker.append(point)
                queue.append(contentsOf: matrix.getAdjacentPoints(to: point, includeDiag: true).values)

            }
        }
        for point in flashedTracker {
            flashesCount += 1
            matrix.setVal(at: point, to: 0)
        }
        return (matrix,flashesCount)
    }

    func part1() -> Any {
        var matrix = Matrix(data)
        var flashesCount = 0
        for _ in 1...100 {
            var flashesTmp = 0
            (matrix,flashesTmp) = step(matrix: matrix)
            flashesCount += flashesTmp
        }
        return flashesCount
    }

    func part2() -> Any {
        var matrix = Matrix(data)
        var steps = 0
        while !matrix.allSatisfy({ $0 == 0 }) {
            (matrix,_) = step(matrix: matrix)
            steps += 1
        }
        return steps
    }
}


/*
 Pt 1 test target: 1656
 pt 2 test target: 195
 */
fileprivate let testInput = Data(raw: """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
""")

