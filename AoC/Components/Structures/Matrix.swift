//
//  Matrix.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/16/21.
//

struct Matrix<T> {
    private var raw:[[T]]
    lazy var width = raw.count
    lazy var hight = raw.first!.count
    var data: [[T]] {
        get {
            return raw
        }
    }
    
    init(_ inp: [[T]]) {
        raw = inp
    }

    mutating func getAdjacent(to loc: (x:Int,y:Int), includeDiag:Bool) -> [String:T] {
        guard loc.x >= 0 && loc.x <= width else { fatalError("X is out of range") }
        guard loc.y >= 0 && loc.y <= hight else { fatalError("Y is out of range") }
        var adj:[String:T] = [:]
        if loc.y - 1 >= 0 { adj["up"] = raw[loc.x][loc.y - 1] }
        if loc.x + 1 <= width - 1 { adj["right"] = raw[loc.x + 1][loc.y] }
        if loc.y + 1 <= hight - 1 { adj["down"] = raw[loc.x][loc.y + 1] }
        if loc.x - 1 >= 0 { adj["left"] = raw[loc.x - 1][loc.y] }
        if includeDiag {
            if loc.x - 1 >= 0 && loc.y - 1 >= 0{ adj["up-left"] = raw[loc.x - 1][loc.y - 1] }
            if loc.x + 1 <= width - 1 && loc.y - 1 >= 0 { adj["up-right"] = raw[loc.x + 1][loc.y - 1] }
            if loc.x + 1 <= width && loc.y + 1 <= hight - 1 { adj["down-right"] = raw[loc.x + 1][loc.y + 1] }
            if loc.x - 1 >= 0 && loc.y + 1 <= hight - 1 { adj["down-left"] = raw[loc.x - 1][loc.y + 1] }
        }
        return adj
    }
    
    mutating func getAdjacent(to loc: Point, includeDiag:Bool) -> [String:T] {
        getAdjacent(to: (x:loc.x,y:loc.y), includeDiag:includeDiag)
    }
    
    mutating func getAdjacentPoints(to loc: (x:Int,y:Int), includeDiag:Bool) -> [String:Point] {
        guard loc.x >= 0 && loc.x <= width else { fatalError("X is out of range") }
        guard loc.y >= 0 && loc.y <= hight else { fatalError("Y is out of range") }
        var adj:[String:Point] = [:]
        if loc.y - 1 >= 0 { adj["up"] = Point(x:loc.x,y:loc.y - 1) }
        if loc.x + 1 <= width - 1 { adj["right"] = Point(x:loc.x + 1,y:loc.y) }
        if loc.y + 1 <= hight - 1 { adj["down"] = Point(x:loc.x,y:loc.y + 1) }
        if loc.x - 1 >= 0 { adj["left"] = Point(x:loc.x - 1,y:loc.y) }
        if includeDiag {
            if loc.x - 1 >= 0 && loc.y - 1 >= 0{ adj["up-left"] = Point(x:loc.x - 1,y:loc.y - 1) }
            if loc.x + 1 <= width - 1 && loc.y - 1 >= 0 { adj["up-right"] = Point(x:loc.x + 1,y:loc.y - 1) }
            if loc.x + 1 <= width - 1 && loc.y + 1 <= hight - 1 { adj["down-right"] = Point(x:loc.x + 1,y:loc.y + 1) }
            if loc.x - 1 >= 0 && loc.y + 1 <= hight - 1 { adj["down-left"] = Point(x:loc.x - 1,y:loc.y + 1) }
        }
        return adj
    }
    
    mutating func getAdjacentPoints(to loc: Point, includeDiag:Bool) -> [String:Point] {
        getAdjacentPoints(to: (x:loc.x,y:loc.y), includeDiag:includeDiag)
    }
    
    mutating func getVal(at loc: (x:Int, y:Int)) -> T {
        guard loc.x >= 0 && loc.x < width else { fatalError("X is unreachable") }
        guard loc.y >= 0 && loc.y < hight else { fatalError("Y is unreachable") }
        return raw[loc.x][loc.y]
    }
    
    mutating func getVal(at loc: Point) -> T {
        getVal(at: (x:loc.x, y:loc.y))
    }
    
    mutating func setVal(at loc: (x:Int, y:Int), to newVal: T) {
        guard loc.x >= 0 && loc.x < width else { fatalError("X is unreachable") }
        guard loc.y >= 0 && loc.y < hight else { fatalError("Y is unreachable") }
        raw[loc.x][loc.y] = newVal
    }
    
    mutating func setVal(at loc: Point, to newVal: T) {
        setVal(at: (x:loc.x, y:loc.y), to: newVal)
    }
    
    func allSatisfy(_ element: (T) -> Bool) -> Bool {
        return raw.allSatisfy { $0.allSatisfy(element) }
    }
    
}

