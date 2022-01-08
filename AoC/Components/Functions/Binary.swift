//
//  Binary.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/3/21.
//

import Foundation

func bin2int(_ inp: String) -> Int {
    /*
    Uses the Darwin C Standard Lib to interprit a string  of binary
    digits as an integer value.
    */
    return Int(strtoul(inp, nil, 2))
}
