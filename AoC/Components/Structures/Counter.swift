//
//  Counter.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/9/22.
//

import Foundation

struct Counter<T:Hashable> {
    var items: [T : Int] = [:]
    
//    func add<T>(item: T) {
//        if items.has(key: item) { items[item]! += 1 }
//        else { items[item] = 1 }
//    }
}

struct PointCounter {
    var items: [Point : Int] = [:]
    lazy var count: Int = items.count
    
    mutating func count(item: Point) {
        if items.has(key: item) { items[item]! += 1 }
        else { items[item] = 1 }
    }
    
    func getCount(for item: Point) -> Int {
        return items[item, default: 0]
    }
    
    func getAllCounts() -> Int {
        return items.reduce(0) { $0 + $1.value }
    }
}
