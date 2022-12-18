//
//  Sequen e.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/17/22.
//

import Foundation

extension Sequence {
    func toDictionary<Key: Hashable, Value>(where closure: (Element) -> (Key, Value)) -> [Key: Value] {
        reduce(into: [Key: Value]()) { (result, element) in
            let components = closure(element)
            result[components.0] = components.1
        }
    }
    
    func toCompactDictionary<Key: Hashable, Value>(where closure: (Element) -> ((Key, Value)?)) -> [Key: Value] {
        reduce(into: [Key: Value]()) { (result, element) in
            guard let components = closure(element) else { return }
            result[components.0] = components.1
        }
    }
}
