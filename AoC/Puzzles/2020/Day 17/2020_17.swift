//
//  2020_17.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/22/20.
//


import Foundation

struct p2020_17: Puzzle {
//    var data = testInput.parseToStringArray()
    var data = input_2020_17.parseToStringArray()
    var runPart = 2
    
    enum State: String {
        case active = "#"
        case inactive = "."
    }

    struct Point: Hashable {
        let coords: (x: Int, y: Int, z: Int, w: Int)
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(coords.x)
            hasher.combine(coords.y)
            hasher.combine(coords.z)
            hasher.combine(coords.w)
        }
        
        static func ==(lhs: Point, rhs: Point) -> Bool {
            return lhs.coords == rhs.coords
        }
    }

        
    func bootUp(dimensions: Int) -> Int {
            var theMatrix = parseData()
            
            for _ in 1...6 {  // Boot Cycle
                biggifyTheMatrix(matrix: &theMatrix, dimensions: dimensions)
                let matrixTmp = theMatrix
                for (point, state) in matrixTmp {
                    let activeNeighbors = countNeighbors(point: point,
                                                               matrix: matrixTmp,
                                                               dimensions: dimensions)
                    
                    if state == .active && !(2...3).contains(activeNeighbors) {
                        theMatrix[point] = .inactive
                    } else if activeNeighbors == 3 {
                        theMatrix[point] = .active
                    }
                }
            }
            
            let active = theMatrix.filter {
                $0.value == .active
            }
            
            return active.count
        }
        
        func biggifyTheMatrix(matrix: inout [Point: State], dimensions: Int) {
            var x = (0,0)
            var y = (0,0)
            var z = (0,0)
            var w = (0,0)
            
            for (point, _) in matrix {
                x = (min(point.coords.0, x.0), max(point.coords.0, x.1))
                y = (min(point.coords.1, y.0), max(point.coords.1, y.1))
                z = (min(point.coords.2, z.0), max(point.coords.2, z.1))
                w = (min(point.coords.3, w.0), max(point.coords.3, w.1))
            }
            
            x = (x.0 - 1, x.1 + 1)
            y = (y.0 - 1, y.1 + 1)
            z = (z.0 - 1, z.1 + 1)
            w = (w.0 - 1, w.1 + 1)
            
            for xIdx in (x.0)...(x.1) {
                for yIdx in (y.0)...(y.1) {
                    for zIdx in (z.0)...(z.1) {
                        if dimensions == 3 {
                            if matrix[Point(coords: (x: xIdx, y: yIdx, z: zIdx, w: 0))] == nil {
                                matrix[Point(coords: (x: xIdx, y: yIdx, z: zIdx, w: 0))] = .inactive
                            }
                        } else {
                            for wIdx in (w.0)...(w.1) {
                                if matrix[Point(coords: (x: xIdx, y: yIdx, z: zIdx, w: wIdx))] == nil {
                                    matrix[Point(coords: (x: xIdx, y: yIdx, z: zIdx, w: wIdx))] = .inactive
                                }
                            }
                        }
                    }
                }
            }
        }
        
        func countNeighbors(point: Point, matrix: [Point: State], dimensions: Int) -> Int {
            var activeCount = 0
            
            for x in -1...1 {
                for y in -1...1 {
                    for z in -1...1 {
                        if dimensions == 3 {
                            if  x == 0 && y == 0 && z == 0 { continue }
                            if matrix[Point(coords: (x: point.coords.0 + x,
                                                     y: point.coords.1 + y,
                                                     z: point.coords.2 + z,
                                                     w: 0))] == .active {
                                activeCount += 1
                            }
                        } else {
                            for w in -1...1 {
                                if  x == 0 && y == 0 && z == 0 && w == 0 { continue }
                                if matrix[Point(coords: (x: point.coords.0 + x,
                                                         y: point.coords.1 + y,
                                                         z: point.coords.2 + z,
                                                         w: point.coords.3 + w))] == .active {
                                    activeCount += 1
                                }
                            }
                        }
                    }
                }
            }
            
            return activeCount
        }
    
    func parseData() -> [Point: State] {
        var matrix: [Point: State] = [:]
        for (row, col) in data.enumerated() {
            for (column, pnt) in col.enumerated() {
                matrix[Point(coords: (x: column, y: row, z: 0, w: 0))] = State(rawValue: String(pnt))
            }
        }
        
        return matrix
    }

    func part1() -> Any {
        return bootUp(dimensions: 3)
    }

    func part2() -> Any {
        bootUp(dimensions: 4)
    }
}


fileprivate let testInput = Data(raw: """
.#.
..#
###
""")



