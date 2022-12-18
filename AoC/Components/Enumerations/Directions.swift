//
//  Directions.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/14/20.
//

public enum CardinalDirection: CaseIterable {
    case north
    case south
    case east
    case west
}

public enum RelativeDirection: CaseIterable {
    case forward
    case back
    case left
    case right
}

public enum Heading: CaseIterable {
    case up
    case down
    case left
    case right
}

public enum UltimateHeading: CaseIterable {
    case top
    case bottom
    case left
    case right
}

public enum Axis2: CaseIterable {
    case x
    case y
}

public enum Axis3: CaseIterable {
    case x
    case y
    case z
}
