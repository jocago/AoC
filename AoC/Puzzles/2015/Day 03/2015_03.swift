//
//  2015_03.swift
//  AoC
//
//  Created by Joshua Gohlke on 2/13/21.
//


import Foundation

struct p2015_03: Puzzle {
    //var data = testInput.raw.charactersArray
    var data = input_2015_03.raw.charactersArray
    var runPart = 2
    
    func getDirs(point: Point, step: Character) -> Point {
        switch step {
        case "^":
            return point + Point(x: 0, y: 1)
        case ">":
            return point + Point(x: 1, y: 0)
        case "v":
            return point + Point(x: 0, y: -1)
        case "<":
            return point + Point(x: -1, y: 0)
        default:
            fatalError("No appropriate direction was found: \(step)")
        }
    }

    func part1() -> Any {
        var point: Point = Point(x: 0,y: 0)
        var hist: [Point: Int] = [:]
        
        for step in data {
            point = getDirs(point: point, step: step)
            if hist.has(key: point) {
                hist[point]! += 1
            } else {
                hist[point] = 1
            }
        }
        
        return hist.count
    }

    func part2() -> Any {
        var points: (santa: Point, santaBot: Point) = (Point(x: 0, y: 0),Point(x: 0, y: 0))
        var hist: [Point: Int] = [:]
        var isBotTurn = false
        var point: Point
        for step in data {
            if isBotTurn {
                point = points.santaBot
            } else {
                point = points.santa
            }
            point = getDirs(point: point, step: step)
            if hist.has(key: point) {
                hist[point]! += 1
            } else {
                hist[point] = 1
            }
            if isBotTurn {
                points.santaBot = point
            } else {
                points.santa = point
            }

            isBotTurn.toggle()
        }
        return hist.count
    }
}


fileprivate let testInput = Data(raw: """
^>v<
""") //  4 / 3



