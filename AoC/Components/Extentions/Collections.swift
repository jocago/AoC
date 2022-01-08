//
//  Collections.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/28/21.
//

import Foundation

public extension Collection where Element: Hashable {
    func getMostCommonValueCount() -> Int {
        var counter:[Element:Int] = [:]
        self.forEach { element in
            counter[element, default: 0] += 1
        }
        return counter.values.max()!
    }
    
    func getMostCommonValue() -> Element {
        var counter:[Element:Int] = [:]
        self.forEach { element in
            counter[element, default: 0] += 1
        }
        return counter.first(where: {$0.value == counter.values.max()!})!.key
    }
    
    func getLeastCommonValueCount() -> Int {
        var counter:[Element:Int] = [:]
        self.forEach { element in
            counter[element, default: 0] += 1
        }
        return counter.values.min()!
    }
    
    func getLeastCommonValue() -> Element {
        var counter:[Element:Int] = [:]
        self.forEach { element in
            counter[element, default: 0] += 1
        }
        return counter.first(where: {$0.value == counter.values.min()!})!.key
    }
}
