
import Foundation

struct p2022_9: Puzzle {
    //var data = testInput.parseToStringArray()
    //var data = testInput2.parseToStringArray()
    var data = input_2022_9.parseToStringArray()
    var runPart = 2
    
    func tailMove(hLoc: Point, tLoc: Point) -> Point{
        // up       =>  y+
        // down     =>  y-
        // right    =>  x+
        // left     =>  x-
        var tLoc = tLoc
        if hLoc.y - tLoc.y > 1 {
            // tail is below head
            tLoc.y = hLoc.y - 1
            tLoc.x = hLoc.x // diag
        }
        else if tLoc.y - hLoc.y > 1 {
            // tail is above head
            tLoc.y = hLoc.y + 1
            tLoc.x = hLoc.x // diag
        }
        else if hLoc.x - tLoc.x > 1 {
            // tail is left of head
            tLoc.x = hLoc.x - 1
            tLoc.y = hLoc.y // diag
        }
        else if tLoc.x - hLoc.x > 1 {
            // tail is right of head
            tLoc.x = hLoc.x + 1
            tLoc.y = hLoc.y // diag
        }
        return tLoc
    }
    
    func getDirection(from instr: String) -> Point {
        var dir: Point
        switch instr {
        case "R":
            dir = Point(x: 1, y: 0)
        case "U":
            dir = Point(x: 0, y: 1)
        case "D":
            dir = Point(x: 0, y: -1)
        case "L":
            dir = Point(x: -1, y: 0)
        default:
            dir = Point(x: 0, y: 0)
        }
        return dir
    }

    func part1() -> Any {
        var head = Point(x: 0, y: 0)
        var tail = Point(x: 0, y: 0)
        var tailHist = PointCounter()
        tailHist.count(item: tail)
        for item in data {
            let ins = item.split(separator: " ")
            let dir = getDirection(from: String(ins[0]))
            for _ in 1...Int(ins[1])! {
                head = head + dir
                let tmpTail = self.tailMove(hLoc: head, tLoc: tail)
                if tmpTail != tail {
                    tail = tmpTail
                    tailHist.count(item: tail)
                }
            }
        }
        
        return tailHist.count
    }

    func part2() -> Any {
        var head = Point(x: 0, y: 0)
        var knots = Array(repeating: Point(x: 0, y: 0), count: 9)
        var tailHist = PointCounter()
        tailHist.count(item: knots[8])
        for item in data {
            let ins = item.split(separator: " ")
            let dir = getDirection(from: String(ins[0]))
            for _ in 1...Int(ins[1])! {
                head = head + dir
                knots[0] = self.tailMove(hLoc: head, tLoc: knots[0])
                for i in 1...7 {
                    knots[i] = self.tailMove(hLoc: knots[i-1], tLoc: knots[i])
                }
                let tmpTail = self.tailMove(hLoc: knots[7], tLoc: knots[8])
                if tmpTail != knots[8] {
                    knots[8] = tmpTail
                    tailHist.count(item: knots[8])
                }
            }
        }
        
        return tailHist.count
    }
}


/*
 Pt 1 test target: 13
 pt 2 test target: 1
 */
fileprivate let testInput = Data(raw: """
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
""")

// pt 2 test 2 target: 36
fileprivate let testInput2 = Data(raw: """
R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20
""")


