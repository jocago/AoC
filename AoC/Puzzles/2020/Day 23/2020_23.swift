//
//  2020_23.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/25/20.
//

// Not Finished

import Foundation

struct p2020_23: Puzzle {
    var data = testInput.raw.charactersArray.map { Int(String($0))! }
    var runPart = 1
    
    /*
     Because both the example and input have 9 "cups" labled 1-9, I'll use hardcoded values.
     Count = 9
     Min = 1
     Max = 9
     */

    func part1() -> Any {
        var cups = data
        var cupPtr = 0
        
        func safeRemove(arr: inout [Int], at loc: Int) -> Int {
            return arr.remove(at: loc < arr.count ? loc : 0)
        }
        
        for _ in 1...100 {  // The crab is then going to do 100 moves.
            // 1) The crab picks up the three cups that are immediately clockwise of the current cup. They are removed from the circle; cup spacing is adjusted as necessary to maintain the circle.
            let one = safeRemove(arr: &cups,at: cupPtr + 1)
            let two = safeRemove(arr: &cups,at: cupPtr + 1)
            let three = safeRemove(arr: &cups,at: cupPtr + 1)
                        
            // 2) The crab selects a destination cup: the cup with a label equal to the current cup's label minus one. If this would select one of the cups that was just picked up, the crab will keep subtracting one until it finds a cup that wasn't just picked up. If at any point in this process the value goes below the lowest value on any cup's label, it wraps around to the highest value on any cup's label instead.
            
            // get the current val
            let cVal = cups[cupPtr]
            // find the next lower val that exists...
            var nextLowerVal = -1
            if cups.min()! < cVal { // target next val is lower than current val
                for i in 1..<cVal {
                    if cups.contains(cVal - i) { nextLowerVal = cVal - i }
                }
            } else {  // need to start at the top and work back down
                for i in 0..<(9 - cVal) {
                    if cups.contains(9 - i) { nextLowerVal = 9 - i }
                }
            }
            // set to destination to the idx of that val
            guard nextLowerVal >= 0 else { fatalError("Never got that next lower val") }
            let destCup  = cups.firstIndex(of: nextLowerVal)! + 1
            
            // 3) The crab places the cups it just picked up so that they are immediately clockwise of the destination cup. They keep the same order as when they were picked up.
            cups.insert(three, at: destCup)
            cups.insert(two, at: destCup)
            cups.insert(one, at: destCup)
            
            // 4) The crab selects a new current cup: the cup which is immediately clockwise of the current cup.
            cupPtr = (cupPtr + 1) < 9 ? cupPtr + 1 : 0
        }
        
        let ret = cups + cups
        let s = ret.firstIndex(of: 1)! + 1
        let f = ret.lastIndex(of: 1)! - 1
        return ret[s...f]
    }

    func part2() -> Any {
        return 0
    }
}


fileprivate let testInput = Data(raw: """
389125467
""")  //  67384529



