//
//  Point.swift
//  AoC
//
//  Created by Joshua Gohlke on 2/13/21.
//

import Foundation


protocol CoordinatePoint: Hashable, CustomStringConvertible {
    var coords: [Int] { get }
    var dimensions: Int { get }
}

extension CoordinatePoint {
    var x: Int { return coords[0] }
    var y: Int { return coords[1] }
    var z: Int? {
        if coords.count > 2 { return coords[2] }
        else { return nil }
    }
    var t: Int? {
        if coords.count > 3 { return coords[3] }
        else { return nil }
    }
    var description: String {
        return "(" + coords.map { $0.description }.joined(separator: ", ") + ")"
        
    }
    
    static func +(lhs: Self, rhs: Point) -> Point {
        guard lhs.coords.count == rhs.coords.count else {
            fatalError("Coordinate dimensions are incompatible.")
        }
        var response: [Int] = []
        switch lhs.coords.count {
        case 4:
            response.append(lhs.t! + rhs.t!)
            fallthrough
        case 3:
            response.append(lhs.z! + rhs.z!)
            fallthrough
        case 2:
            response.append(lhs.x + rhs.x)
            response.append(lhs.y + rhs.y)
        default:
            fatalError("No appropriate coords case was found for \(lhs.coords.count).")
        }
        switch response.count {
        case 2:
            return Point(x: response[0], y: response[1])
        case 3:
            return Point(x: response[0], y: response[1], z: response[2])
        case 4:
            return Point(x: response[0], y: response[1], z: response[2], t: response[3])
        default:
            fatalError("No appropriate response case was found for \(response.count).")
        }
    }
}

struct Point: CoordinatePoint {
    var coords: [Int] = []
    var dimensions = 0
    
    init(x: Int, y: Int) {
        self.coords.append(x)
        self.coords.append(y)
        self.dimensions = 2
    }
    
    init(x: Int, y: Int, z: Int) {
        self.coords.append(x)
        self.coords.append(y)
        self.coords.append(z)
        self.dimensions = 3
    }
    
    init(x: Int, y: Int, z: Int, t: Int) {
        self.coords.append(x)
        self.coords.append(y)
        self.coords.append(z)
        self.coords.append(t)
        self.dimensions = 4
    }
    
}


