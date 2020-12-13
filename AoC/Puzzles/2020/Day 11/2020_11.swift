//
//  2020_11.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/12/20.
//

/* I went a little overboard on the structure for this one, but it was fun and actually made pt2 easier. */

import Foundation

struct p2020_11: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2020_11.parseToStringArray()
    var runPart = 2
    var debug = false
    
    
    enum CellType {
        case chair
        case floor
    }
    
    enum CellState {
        case occupied
        case vacant
    }
    
    class Cell {
        var type: CellType
        private var __state: CellState = .vacant
        private var __preFrameState: CellState = .vacant
        private var __neighbors: [Cell] = []
        var x: Int
        var y: Int
        var complexRules: Bool
        
        init(type: CellType, x: Int, y: Int, complex: Bool) {
            self.type = type
            self.x = x
            self.y = y
            self.complexRules = complex
        }
        
        func getState() -> CellState { return __preFrameState }
        
        func add(neighbor: Cell) {
            if neighbor.type == .chair { __neighbors.append(neighbor) } // floor will always be vacant
        }
        
        func runFrame() -> (CellState, Bool) { // did state change?
            // 1. If is empty and no occupied seats adjacent, becomes occupied
            if __state == .vacant {
                var emptyArea = true
                for i in 0..<__neighbors.count {
                    if __neighbors[i].getState() == .occupied {
                        emptyArea = false
                        break
                    }
                }
                if emptyArea {
                    __state = .occupied
                    return (__state, true)  // change vac to occ
                    
                }
            }
            // 2. If is occupied and four or more adjacent are occupied, becomes empty
            if __state == .occupied {
                var cntOccupied = 0
                for i in 0..<__neighbors.count {
                    if __neighbors[i].getState() == .occupied {
                        cntOccupied += 1
                    }
                    if cntOccupied >= (complexRules ? 5 : 4) {
                        __state = .vacant
                        return (__state, true)  // change occ to vac
                    }
                }
            }
            
            return (__state, false) // no state change
        }
        
        func update() {
            __preFrameState = __state
        }
    }
    
    class Chair: Cell {
       
        init(x: Int, y: Int, complex: Bool = false) {
            super.init(type: .chair, x: x, y: y, complex: complex)
        }
        
    }
    
    class Floor: Cell {
        
        init(x: Int, y: Int, complex: Bool = false) {
            super.init(type: .floor, x: x, y: y, complex: complex)
        }
        
        override func runFrame() -> (CellState, Bool) {
            return (.vacant, false) // it's a floor and it'll alway be a floor
        }
        
    }
    
    func nike(complex: Bool = false) -> [[Cell]] {
        var grid: [[Cell]] = []
        var x = 0
        var y = 0
        for row in data {
            y = 0
            var tmp: [Cell] = []
            for char in row {
                if char == "L" { tmp.append(Chair(x: x, y: y, complex: complex)) }
                else if char == "." { tmp.append(Floor(x: x, y: y, complex: complex)) }
                y += 1
            }
            grid.append(tmp)
            x += 1
        }
        for i in 0..<grid.count {
            for j in 0..<grid[0].count {
                for v in -1...1 {
                    for h in -1...1 {
                        var iv = i + v
                        var jh = j + h
                        if iv >= 0 && iv < grid.count && jh >= 0 && jh < grid[0].count && !(v == 0 && h == 0) {
                            if complex {
                                while grid[iv][jh].type == .floor {
                                    // keep looking in that direction
                                    if v > 0 { iv += 1 } else if v < 0 { iv -= 1 }
                                    if h > 0 { jh += 1 } else if h < 0 { jh -= 1 }
                                    guard iv >= 0 && iv < grid.count else {
                                        iv = i + v
                                        jh = j + h
                                        break
                                    }
                                    guard jh >= 0 && jh < grid[0].count else {
                                        iv = i + v
                                        jh = j + h
                                        break
                                    }
                                }
                            }
                            grid[i][j].add(neighbor: grid[iv][jh])
                        }
                    }
                    
                }
            }
        }
        return grid
    }
    
    func show(grid: [[Cell]]) {
        for r in grid {
            var row = ""
            for c in r {
                if c.type == .floor { row += "."}
                else if c.getState() == .occupied { row += "#" }
                else { row += "L" }
            }
            print(row)
        }
    }
    
    func peek(complex: Bool = false) -> Int {
        let grid = nike(complex: complex)
        var didChange = true
        var rounds = 0
        var numOccupied = 0
        while didChange == true {
            didChange = false
            numOccupied = 0
            
            for each in grid {
                for every in each {
                    let (state, changed) = every.runFrame()
                    if changed { didChange = true }
                    if state == .occupied { numOccupied += 1 }
                }
            }
            for each in grid {
                for every in each {
                    every.update()
                }
            }
            rounds += 1
            if debug {
                print(rounds)
                show(grid: grid)
            }
        }
        return numOccupied
    }

    func part1() -> Any {
        return peek()
    }

    func part2() -> Any {
        return peek(complex: true)
    }
}


fileprivate let testInput = Data(raw: """
L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL
""")



