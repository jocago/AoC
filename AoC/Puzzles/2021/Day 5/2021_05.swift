
import Foundation

struct p2021_5: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2021_5.parseToStringArray()
    var runPart = 2
    
    struct Coord: Hashable {
        var x: Int
        var y: Int
    }
    
    struct Line {
        var start:Coord
        var stop:Coord
        var isDiag: Bool {
            start.x != stop.x && start.y != stop.y
        }
        
        func getFullLine() -> [Coord] {
            var line:[Coord] = []
            var x = start.x
            var y = start.y
            line.append(start)
            while x != stop.x || y != stop.y {
                if x < stop.x { x += 1}
                else if x > stop.x { x -= 1 }
                if y < stop.y { y += 1 }
                else if y > stop.y { y -= 1 }
                line.append(Coord(x: x, y: y))
            }
            return line
        }
    }
    
    func parseDataAgain(_ arr: [String]) -> [Line] {
        var lines:[Line] = []
        for row in arr {
            let rowparts = row.replacingOccurrences(of: " -> ", with: "|")
            let lineparts = rowparts.split(separator: "|")
            var tmp:[[Int]] = []
            for part in lineparts {
                tmp.append(part.split(separator: ",").map( { Int($0)! } ))
            }
            let line = Line(start: Coord(x: tmp[0][0], y: tmp[0][1]),
                            stop: Coord(x: tmp[1][0], y: tmp[1][1]))
            lines.append(line)
        }
        return lines
    }
    
    func printLines(_ lines: [Line]) {
        /*
         Yes, this is a heavy-handed test.
         So what?
         */
        for line in lines {
            print("\(line.start.x),\(line.start.y) -> \(line.stop.x),\(line.stop.y): diag:\(line.isDiag) -  \(line.getFullLine())")
        }
    }
    
    func countIntersections(_ lines: [Line], includeDiags: Bool) -> Int {
        var counts:[Coord:Int] = [:]
        for line in lines {
            if line.isDiag  && includeDiags || line.isDiag == false {
                for coord in line.getFullLine() {
                    counts[coord, default: 0] += 1
                }
            }
        }
        return counts.values.count(where: { $0 >= 2 })
    }
    

    func part1() -> Any {
        let lines = parseDataAgain(data)
        //printLines(lines)
        return countIntersections(lines, includeDiags: false)
    }

    func part2() -> Any {
        let lines = parseDataAgain(data)
        //printLines(lines)
        return countIntersections(lines, includeDiags: true)
    }
}


/*
 Pt 1 test target: 5
 pt 2 test target: 12
 */
fileprivate let testInput = Data(raw: """
0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2
""")


