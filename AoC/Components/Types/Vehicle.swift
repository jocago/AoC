//
//  Vehicle.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/14/20.
//

// !!! Not ready for prime time.
// TODO: Debugging needed

import Foundation
import SwifterSwift

class Vehicle {
    var location = (x: 0, y: 0)
    private var originalLocation = (x: 0, y: 0) // for tracking
    var totalDist = 0
    var waypoint = (x: 0, y: 0)
    var heading = 0  { // degrees, assumed to be facing east or right
        didSet {
            if heading > 360 { heading -= 360 }
            else if heading < 0 { heading += 360 }
        }
    }
    
    // MARK: Init
    init() {}
    
    init(x: Int, y: Int) {
        location.x = x
        location.y = y
        originalLocation.x = x
        originalLocation.y = y
    }
    
    init(x: Int, y: Int, heading: Int) {
        location.x = x
        location.y = y
        originalLocation.x = x
        originalLocation.y = y
        self.heading = heading
    }
    
    // MARK: Turning
    func turn(positiveDegrees degrees: Int) {
        heading += degrees
    }
    
    func turn(relativeDegrees degrees: Int, direction: RelativeDirection) {
        switch direction {
        case .right:
            heading += degrees
        case .left:
            heading -= degrees
        case .back:
            heading -= 180
        case .forward:
            ()
        }
        
    }
    
    func turnTo(degrees: Int) {
        heading = degrees
    }
    
    func turnTo(direction: CardinalDirection) {
        switch direction {
        case .north:
            heading = 270
        case .east:
            heading = 0
        case .south:
            heading = 90
        case .west:
            heading = 180
        }
    }
    // MARK: Targeting
    func setWaypointTo(x: Int, y: Int) {
        waypoint.x = x
        waypoint.y = y
    }
    
    func moveWaypoint(relative: (x: Int, y: Int)) {
        waypoint.x += relative.x
        waypoint.y += relative.y
    }
    
    func moveWaypoint(direction: CardinalDirection, amount: Int) {
        switch direction {
        case .east:
            waypoint.x += amount
        case .south:
            waypoint.y -= amount
        case .west:
            waypoint.x -= amount
        case .north:
            waypoint.y += amount
        }
    }
    
    func orbitWaypoint(direction: RelativeDirection, amount: Int) {
        var 🤘 = 0
        var 👊 = 0
        switch direction {
        case .left:
            🤘 = Int(cos(amount.degreesToRadians))
            👊 = Int(sin(amount.degreesToRadians))
        case .right:
            🤘 = Int(cos(-amount.degreesToRadians))
            👊 = Int(sin(-amount.degreesToRadians))
        case .back:
            🤘 = 0
            👊 = 1
        case .forward:
            ()
        }
        
        let x = waypoint.x * 🤘 - waypoint.y * 👊
        let y = waypoint.x * 👊 + waypoint.y * 🤘
        waypoint.x = x
        waypoint.y = y
    }
    
    // MARK: Moving
    func moveToward(x: Int, y: Int, amount: Int, setHeading: Bool = true) {
        // TODO: Set (conditional) the heading to the direction of the waypoint
        location.x += x * amount
        location.y += y * amount
        totalDist += amount
    }
    
    func moveTowardWaypoint(amount: Int, setHeading: Bool = true) {
        moveToward(x: waypoint.x, y: waypoint.y, amount: amount, setHeading: setHeading)
    }
    
    func moveInDirection(direction: CardinalDirection, amount: Int, setHeading: Bool = true) {
        // TODO: Set (conditional) the heading to the direction of the waypoint
        switch direction {
        case .east:
            location.x += amount
        case .south:
            location.y -= amount
        case .west:
            location.x -= amount
        case .north:
            location.y += amount
        }
        totalDist += amount
    }
    
    func moveForward(amount: Int) {
        location.x += amount * Int(cos(heading.degreesToRadians))
        location.y += amount * Int(sin(heading.degreesToRadians))
    }
    
    // MARK: Tracking
    func getManhattanDist() -> Int {
        return abs(location.x - originalLocation.x) + abs(location.y - originalLocation.y)
    }
    
    func getManhattanDist(from: (x: Int, y: Int)) -> Int {
        return abs(location.x - from.x) + abs(location.y - from.y)
    }
    
    func getManhattanDist(to: (x: Int, y: Int)) -> Int {
        return abs(to.x - location.x) + abs(to.y - location.y)
    }

}

