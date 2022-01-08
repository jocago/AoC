//
//  Integers.swift
//  AoC
//
//  Created by Joshua Gohlke on 1/6/22.
//

import Foundation

extension Int {
    var bits:[Bool] {
        var bArr = Array<Bool>()
        (0..<self.bitWidth).forEach { offset in
            bArr.append((self & (1 << offset)) > 0)
        }
        return bArr.reversed()
    }
    
    var binaryString:String { self.bits.map({ $0 ? "1" : "0" }).joined(separator:"") }
}
