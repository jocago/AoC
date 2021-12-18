//
//  Matrix.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/16/21.
//

struct Matrix<T> {
    private let raw:[[T]]
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

    mutating func getCardinalAdjacent(to loc: (x:Int,y:Int)) -> [String:T] {
        guard loc.x >= 0 && loc.x <= width else { fatalError("X is out of range") }
        guard loc.y >= 0 && loc.y <= hight else { fatalError("Y is out of range") }
        var cardinals:[String:T] = [:]
        if loc.y - 1 >= 0 { cardinals["up"] = raw[loc.x][loc.y - 1] }
        if loc.x + 1 <= width - 1 { cardinals["right"] = raw[loc.x + 1][loc.y] }
        if loc.y + 1 <= hight - 1 { cardinals["down"] = raw[loc.x][loc.y + 1] }
        if loc.x - 1 >= 0 { cardinals["left"] = raw[loc.x - 1][loc.y] }
        return cardinals
    }
    
    mutating func getVal(at loc: (x:Int, y:Int)) -> T {
        guard loc.x >= 0 && loc.x <= width else { fatalError("X is unreachable") }
        guard loc.y >= 0 && loc.y <= hight else { fatalError("Y is unreachable") }
        return raw[loc.x][loc.y]
    }
    
}

