//
//  Matrix.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/16/21.
//

struct Matrix<T> {
    /// ok, I need to break this into 2D, 3D, and 4D versions.
    /// It's just brokens.
    private var raw: [[T]]
    lazy var width = raw.count
    lazy var height = raw[0].count
    var data: [[T]] {
        get {
            return raw
        }
    }
    
    enum RotateDirection { case left, right }
    typealias xy = (x:Int,y:Int)
    
    init(_ inp: [[T]]) {
        raw = inp
    }

    mutating func getAdjacent(to loc: xy, includeDiag:Bool) -> [String:T] {
        guard loc.x >= 0 && loc.x <= width else { fatalError("X is out of range") }
        guard loc.y >= 0 && loc.y <= height else { fatalError("Y is out of range") }
        var adj:[String:T] = [:]
        if loc.y - 1 >= 0 { adj["up"] = raw[loc.x][loc.y - 1] }
        if loc.x + 1 <= width - 1 { adj["right"] = raw[loc.x + 1][loc.y] }
        if loc.y + 1 <= height - 1 { adj["down"] = raw[loc.x][loc.y + 1] }
        if loc.x - 1 >= 0 { adj["left"] = raw[loc.x - 1][loc.y] }
        if includeDiag {
            if loc.x - 1 >= 0 && loc.y - 1 >= 0{ adj["up-left"] = raw[loc.x - 1][loc.y - 1] }
            if loc.x + 1 <= width - 1 && loc.y - 1 >= 0 { adj["up-right"] = raw[loc.x + 1][loc.y - 1] }
            if loc.x + 1 <= width && loc.y + 1 <= height - 1 { adj["down-right"] = raw[loc.x + 1][loc.y + 1] }
            if loc.x - 1 >= 0 && loc.y + 1 <= height - 1 { adj["down-left"] = raw[loc.x - 1][loc.y + 1] }
        }
        return adj
    }
    
    mutating func getAdjacent(to loc: Point, includeDiag:Bool) -> [String:T] {
        getAdjacent(to: (x:loc.x,y:loc.y), includeDiag:includeDiag)
    }
    
    mutating func getAdjacentPoints(to loc: xy, includeDiag:Bool) -> [String:Point] {
        guard loc.x >= 0 && loc.x <= width else { fatalError("X is out of range") }
        guard loc.y >= 0 && loc.y <= height else { fatalError("Y is out of range") }
        var adj:[String:Point] = [:]
        if loc.y - 1 >= 0 { adj["up"] = Point(x:loc.x,y:loc.y - 1) }
        if loc.x + 1 <= width - 1 { adj["right"] = Point(x:loc.x + 1,y:loc.y) }
        if loc.y + 1 <= height - 1 { adj["down"] = Point(x:loc.x,y:loc.y + 1) }
        if loc.x - 1 >= 0 { adj["left"] = Point(x:loc.x - 1,y:loc.y) }
        if includeDiag {
            if loc.x - 1 >= 0 && loc.y - 1 >= 0{ adj["up-left"] = Point(x:loc.x - 1,y:loc.y - 1) }
            if loc.x + 1 <= width - 1 && loc.y - 1 >= 0 { adj["up-right"] = Point(x:loc.x + 1,y:loc.y - 1) }
            if loc.x + 1 <= width - 1 && loc.y + 1 <= height - 1 { adj["down-right"] = Point(x:loc.x + 1,y:loc.y + 1) }
            if loc.x - 1 >= 0 && loc.y + 1 <= height - 1 { adj["down-left"] = Point(x:loc.x - 1,y:loc.y + 1) }
        }
        return adj
    }
    
    mutating func getAdjacentPoints(to loc: Point, includeDiag:Bool) -> [String:Point] {
        getAdjacentPoints(to: (x:loc.x,y:loc.y), includeDiag:includeDiag)
    }
    
    mutating func getVal(at loc: (x:Int, y:Int)) -> T {
        guard loc.x >= 0 && loc.x < width else { fatalError("X is unreachable") }
        guard loc.y >= 0 && loc.y < height else { fatalError("Y is unreachable") }
        return raw[loc.x][loc.y]
    }
    
    mutating func getVal(at loc: Point) -> T {
        getVal(at: (x:loc.x, y:loc.y))
    }
    
    mutating func setVal(at loc: (x:Int, y:Int), to newVal: T) {
        guard loc.x >= 0 && loc.x < width else { fatalError("X is unreachable") }
        guard loc.y >= 0 && loc.y < height else { fatalError("Y is unreachable") }
        raw[loc.x][loc.y] = newVal
    }
    
    mutating func setVal(at loc: Point, to newVal: T) {
        setVal(at: (x:loc.x, y:loc.y), to: newVal)
    }
    
    func allSatisfy(_ element: (T) -> Bool) -> Bool {
        return raw.allSatisfy { $0.allSatisfy(element) }
    }
    
    func print(spacer:String = " ") {
        for x in 0..<raw.count {
            for y in 0..<raw[0].count {
                let term = y < raw[0].count - 1 ? spacer : "\n"
                Swift.print(raw[x][y],terminator: term)
            }
        }
    }
    
    func count(where matches: (T) -> Bool) -> Int {
        return data.reduce(0) { (agg, row) -> Int in
            return agg + row.count(where: matches)
        }
    }
    
    func reversed(on axis: Axis2) -> Matrix<T> {
        var newMatrix:Matrix<T>
        
        if axis == .y {
            newMatrix = Matrix(self.data.reversed())
        } else  {
            var arr:Array<Array<T>> = []
            for row in data {
                arr.append(row.reversed())
            }
            newMatrix = Matrix(arr)
        }
        
        return newMatrix
    }
    
    func getSubset(with dims: Dictionary<UltimateHeading, Int>) -> Matrix<T> {
        var newData = self.data
        if let top = dims[.top] {
            for _ in 0..<top {
                newData.removeFirst()
            }
        }
        if let bottom = dims[.bottom] {
            for _ in 0..<bottom {
                newData.removeLast()
            }
        }
        if let left = dims[.left] {
            for i in 0..<newData.count {
                var tmpRow = newData.remove(at: i)
                for _ in 0..<left {
                    tmpRow.removeFirst()
                }
                newData.insert(tmpRow, at: i)
            }
        }
        if let right = dims[.right] {
            for i in 0..<newData.count {
                var tmpRow = newData.remove(at: i)
                for _ in 0..<right {
                    tmpRow.removeLast()
                }
                newData.insert(tmpRow, at: i)
            }
        }
        return Matrix(newData)
    }
    
    mutating func rotate(to dir: RotateDirection, times num: Int = 1) {
        for _ in 0..<num {
            if dir == .right { self.rotateRight() }
            else { self.rotateLeft() }
        }
    }
    
    private mutating func rotateRight() {
        self.raw = self.rotateRight(ins: self.raw)
    }
    
    private mutating func rotateRight(ins: [[T]]) -> [[T]] {
        var newMatrix: [[T]] = []
        for i in 0..<ins.count {
            var newRow: [T] = []
            for j in (0..<ins[0].count).reversed() {
                newRow.append(ins[i][j])
            }
            newMatrix.append(newRow)
        }
        return newMatrix
    }
    
    private mutating func rotateLeft() {
        self.raw = self.rotateLeft(ins: self.raw)
    }
    
    private mutating func rotateLeft(ins: [[T]]) -> [[T]] {
        
        //rotate
        return ins
    }
    
    mutating func getEachCoord() -> [xy] {
        var duck: [xy] = []
        for x in 0..<width {
            for y in 0..<height {
                duck.append((x:x,y:y))
            }
        }
        return duck
    }
}

