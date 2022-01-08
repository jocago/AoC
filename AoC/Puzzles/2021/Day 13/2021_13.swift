
import Foundation

struct p2021_13: Puzzle {
    //var data = testInput.parseToBlockOfStringsArray()
    var data = input_2021_13.parseToBlockOfStringsArray()
    var runPart = 2
    
    let emptySpace:Character = " "
    let filledSpace:Character = "#"
    
    fileprivate struct Rule {
        let axis:Axis2
        let place:Int
        
        init(_ inp: String) {
            let tmp = inp.split(separator: "=")
            axis = Character(String(tmp[0].last!)) == "y" ? .y : .x
            place = Int(String(tmp[1]))!
        }
    }
    
    func createPoints(block:[String]) -> Array<Point> {
        let points = block.map { $0.split(separator: ",") }.map { Point(x:Int($0[0])!,y:Int($0[1])!) }
        return points
    }
    
    fileprivate func fold(rule: Rule, points: Set<Point>) -> Set<Point> {
        var newPoints = points
        
        if rule.axis == .x {
            newPoints = Set(
                newPoints.map { point in
                    guard point.x > rule.place else { return point }
                    let newX = (2 * rule.place) - point.x
                    return Point(x: newX, y: point.y)
                }
            )
        } else {
            newPoints = Set(
                newPoints.map { point in
                    guard point.y > rule.place else { return point }
                    let newY = (2 * rule.place) - point.y
                    return Point(x: point.x, y: newY)
                }
            )
        }
        return newPoints
    }

    func part1() -> Any {
        let points = Set(createPoints(block: data[0]))
        let rules = data[1].map { Rule($0) }
        return fold(rule: rules[0], points: points).count
    }

    func part2() -> Any {
        var points = Set(createPoints(block: data[0]))
        let rules = data[1].map { Rule($0) }
        for rule in rules {
            points = fold(rule: rule, points: points)
        }
        let minX = points.min { a, b in a.x < b.x }!.x; let maxX = points.max { a, b in a.x < b.x }!.x
        let minY = points.min { a, b in a.y < b.y }!.y; let maxY = points.max { a, b in a.y < b.y }!.y
        var readout:String = ""
        for y in minY...maxY {
            for x in minX...maxX {
                points.contains(Point(x: x, y: y)) ? readout.append(filledSpace) : readout.append(emptySpace)
            }
        readout.append("\n")
        }
        return readout
    }
}


/*
 Pt 1 test target: 17
 pt 2 test target: A square shape
 */
fileprivate let testInput = Data(raw: """
6,10
0,14
9,10
0,3
10,4
4,11
6,0
6,12
4,1
0,13
10,12
3,4
3,0
8,4
1,10
2,14
8,10
9,0

fold along y=7
fold along x=5
""")


