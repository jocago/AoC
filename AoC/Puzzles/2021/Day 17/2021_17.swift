
import Foundation

struct p2021_17: Puzzle {
    //var data = testInput
    var data = input_2021_17
    var runPart = 2
    
    struct Target {
        let xMin:Int
        let xMax:Int
        let yMin:Int
        let yMax:Int
        var xRange:ClosedRange<Int> { xMin...xMax }
        var yRange:ClosedRange<Int> { yMin...yMax }
        
        init(area:String) {
            let tmp = area.components(separatedBy: ": ")[1].components(separatedBy: ", ")
            let xIndex = tmp[0].index(tmp[0].endIndex, offsetBy: -(tmp[0].count - 2))
            let x = tmp[0].suffix(from: xIndex).components(separatedBy: "..")
            let yIndex = tmp[1].index(tmp[1].endIndex, offsetBy: -(tmp[1].count - 2))
            let y = tmp[1].suffix(from: yIndex).components(separatedBy: "..")
            xMin = Int(x[0])!
            xMax = Int(x[1])!
            yMin = Int(y[0])!
            yMax = Int(y[1])!
        }
    }
    
    struct Probe {
        var position:Point = Point(x: 0, y: 0)
        var velocity:Point
        var highY:Int = Int.min
    }
    
    func fireProbe(target: Target) -> (highY:Int,numValid:Int) {
        var highY = target.yMin // part 1
        var numVelocityValid = 0  // part 2

        for startingXVelocity in 1 ... target.xMax {
            for startingYVelocity in target.yMin ... abs(target.yMin) {
                // The probe's x,y position starts at 0,0.
                var probe = Probe(velocity: Point(x: startingXVelocity, y: startingYVelocity))
                while probe.position.x <= target.xMax && probe.position.y >= target.yMin {
                    // The probe's x position increases by its x velocity.
                    probe.position.x += probe.velocity.x
                    // The probe's y position increases by its y velocity.
                    probe.position.y += probe.velocity.y

                    // Due to drag, the probe's x velocity changes by 1 toward the value 0
                    probe.velocity.x -= probe.velocity.x > 0 ? 1 : probe.velocity.x < 0 ? -1 : 0
                    // Due to gravity, the probe's y velocity decreases by 1.
                    probe.velocity.y -= 1

                    probe.highY = max(probe.highY, probe.position.y)

                    if target.xRange.contains(probe.position.x) &&
                        target.yRange.contains(probe.position.y) {
                        if probe.highY > highY { highY = probe.highY }
                        numVelocityValid += 1
                        break
                    }
                }
            }
        }
        return (highY,numVelocityValid)
    }

    func part1() -> Any {
        let target = Target(area: data.raw)
        return fireProbe(target: target).highY
    }

    func part2() -> Any {
        let target = Target(area: data.raw)
        return fireProbe(target: target).numValid
    }
}


/*
 Pt 1 test target: 45
 pt 2 test target: 112
 */
fileprivate let testInput = Data(raw: """
target area: x=20..30, y=-10..-5
""")


