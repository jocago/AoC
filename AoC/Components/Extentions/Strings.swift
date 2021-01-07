//
//  Strings.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/24/20.
//

import Foundation

extension String {
    
    /*
     Returns a new string excluding the first and last characters of the existing string.
     
     Good for this: (3+3) -> 3+3
     */
    func dropFirstAndLast() -> String {
        return String(self.dropLast().dropFirst())
    }
}
