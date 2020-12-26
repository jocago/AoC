//
//  2020_12.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/13/20.
//


import Foundation
import SwifterSwift

struct p2020_12: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2020_12.parseToStringArray()
    var runPart = 2
    
    enum Hand {
        case left
        case right
    }
    
    struct Waypoint {
        var x: Int
        var y: Int
    }
    
    class Boat {
        var heading: CardinalDirection = .east
        var xPos = 0
        var yPos = 0
        var totalDist = 0
        var manhattanDist: Int {
            return abs(xPos) + abs(yPos)  //boat must start at 0,0
        }
        
        func turn(direction: Hand,  degrees: Int) {
            let clicks = degrees / 90
            let sequence: [CardinalDirection]
            switch direction {
            case .right:
                sequence = [.east,.south,.west,.north,.east,.south,.west]
            case .left:
                sequence = [.east,.north,.west,.south,.east,.north,.west]

            }
            heading = sequence[sequence.firstIndex(of: heading)! + clicks]
        }
        
        private func move(direction: CardinalDirection, dist: Int) {
            switch direction {
            case .east:
                xPos += dist
            case .south:
                yPos -= dist
            case .west:
                xPos -= dist
            case .north:
                yPos += dist
            }
        }
        
        func travel(forward dist: Int) {
            move(direction: heading, dist: dist)
        }
        
        func travel(direction: CardinalDirection, dist: Int) {
            move(direction: direction, dist: dist)
        }
        
        func travel(toward waypoint: Waypoint, dist: Int) {
            xPos += waypoint.x * dist
            yPos += waypoint.y * dist
        }
    }
    
    func testRotationDegrees() {
        var degs: [String: Int] = [:]
        for inst in data {
            if inst.first == "R" {
                if degs.has(key: inst) {
                    degs[inst]! += 1
                } else { degs[inst] = 1 }
                
            }
        }
        print(degs)
    }
    
    func parse(instruction: String) -> (String,Int) {
        return (String(instruction.first!), Int(String(instruction.dropFirst()))!)
    }

    func part1() -> Any {
        let ferry = Boat()
        for line in data {
            let (inst,param) = parse(instruction: line)
            switch inst {
            case "L":
                ferry.turn(direction: .left, degrees: param)
            case "R":
                ferry.turn(direction: .right, degrees: param)
            case "F":
                ferry.travel(forward: param)
            case "E":
                ferry.travel(direction: .east, dist: param)
            case "S":
                ferry.travel(direction: .south, dist: param)
            case "W":
                ferry.travel(direction: .west, dist: param)
            case "N":
                ferry.travel(direction: .north, dist: param)
            default:
                print("bad instruction: \(line)")            }
        }
        return ferry.manhattanDist
    }
    


    func part2() -> Any {
        let ferry = Boat()
        var waypoint = Waypoint(x: 10, y: 1)
        for line in data {
            let (inst,param) = parse(instruction: line)
            switch inst {
                case "N":
                    waypoint.y += param
                case "E":
                    waypoint.x += param
                case "S":
                    waypoint.y -= param
                case "W":
                    waypoint.x -= param
                case "L":
                    let sTmp = Int(sin(param.degreesToRadians))
                    let csTmp = Int(cos(param.degreesToRadians))
                    let x = csTmp * waypoint.x - sTmp * waypoint.y
                    let y = sTmp * waypoint.x + csTmp * waypoint.y
                    waypoint.x = x
                    waypoint.y = y
                case "R":
                    let sTmp = Int(sin(-param.degreesToRadians))
                    let csTmp = Int(cos(-param.degreesToRadians))
                    let x = csTmp * waypoint.x - sTmp * waypoint.y
                    let y = sTmp * waypoint.x + csTmp * waypoint.y
                    waypoint.x = x
                    waypoint.y = y
                case "F":
                    ferry.travel(toward: waypoint, dist: param)
                default:
                    print("bad instruction: \(line)")
            }
        }
        return ferry.manhattanDist
    }
    
}


fileprivate let testInput = Data(raw: """
F10
N3
F7
R90
F11
""")



