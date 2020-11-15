//
//  Input.swift
//  AoC
//
//  Created by Joshua Gohlke on 11/14/20.
//

import Foundation

protocol Input {
    var raw: String { get set }
}

extension Input {
    func parseToIntArray(splitBy: Character = "\n") -> [Int] {
        return raw.split(separator: splitBy).map {Int($0)!}
    }
}

struct Data: Input {
    var raw: String
}
