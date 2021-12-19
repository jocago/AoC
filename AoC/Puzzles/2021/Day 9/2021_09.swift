
import Foundation

struct p2021_9: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2021_9.parseToStringArray()
    var runPart = 2
    
    func getLowPoints(matrix: Matrix<Int>) -> [Point] {
        var matrix = matrix
        var lows:[Point] = []
        for i in 0..<matrix.width {
            for j in 0..<matrix.hight {
                if matrix.getVal(at: (x:i,y:j)) < matrix.getAdjacent(to: (x:i,y:j),
                                                                     includeDiag: false).values.min()! {
                    lows.append(Point(x: i, y: j))
                }
            }
        }
        return lows
    }
    
    func getAdjacentLocs(to loc: Point, from matrix: Matrix<Int>) -> [Point] {
        let width = matrix.data.count
        let hight = matrix.data.first!.count
        var matrix = matrix
        guard loc.x >= 0 && loc.x <= width else { fatalError("X is out of range") }
        guard loc.y >= 0 && loc.y <= hight else { fatalError("Y is out of range") }
        var cardinals:[String:Point] = [:]
        if loc.y - 1 >= 0 {
            if matrix.getVal(at: (x:loc.x,y:loc.y - 1)) != 9  {
                cardinals["up"] = Point(x:loc.x,y:loc.y - 1)
            }
        }
        if loc.x + 1 <= width - 1 {
            if matrix.getVal(at: (x:loc.x + 1,y:loc.y)) != 9 {
                cardinals["right"] = Point(x:loc.x + 1,y:loc.y)
            }
        }
        if loc.y + 1 <= hight - 1 {
            if matrix.getVal(at: (x:loc.x,y:loc.y + 1)) != 9 {
                cardinals["down"] = Point(x:loc.x,y:loc.y + 1)
            }
        }
        if loc.x - 1 >= 0 {
            if matrix.getVal(at: (x:loc.x - 1,y:loc.y)) != 9 {
                cardinals["left"] = Point(x:loc.x - 1,y:loc.y)
            }
        }
        return Array(cardinals.values)
    }

    func part1() -> Any {
        var matrix = Matrix(data.map { $0.charactersArray.map { Int(String($0))! } })
        return getLowPoints(matrix: matrix).reduce(0) { $0 + matrix.getVal(at: (x:$1.x,y:$1.y))+1}
    }

    func part2() -> Any {
        let matrix = Matrix(data.map { $0.charactersArray.map { Int(String($0))! } })
        var basinValues:[Int] = []
        for low in getLowPoints(matrix: matrix) {
            var pointCache:[Point] = [low]
            var basinValue = 1
            var basin:[Point] = [low]
            while !basin.isEmpty {
                let current = basin.removeFirst()
                //print("--\(current)--")
                for adj in getAdjacentLocs(to: current, from: matrix) {
                    //print(adj)
                    if !pointCache.contains(adj) {
                        pointCache.append(adj)
                        basin.append(adj)
                        basinValue += 1
                    }
                }
            }
            basinValues.append(basinValue)
        }
        //print(basinValues)
        return basinValues.sorted().reversed()[0..<3].reduce(1,*)
    }
}


/*
 Pt 1 test target: 15
 pt 2 test target: 1134
 */
fileprivate let testInput = Data(raw: """
2199943210
3987894921
9856789892
8767896789
9899965678
""")

