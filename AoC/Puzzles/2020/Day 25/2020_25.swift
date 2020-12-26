//
//  2020_25.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/25/20.
//


import Foundation

struct p2020_25: Puzzle {
//    var data = testInput.parseToIntArray()
    var data = input_2020_25.parseToIntArray()
    var runPart = 1
    let divModifier = 20201227
    
    func getLoopSize(target: Int) -> Int {
        var value = 1
        var loops = 0
        let subjectNum = 7
        while value != target {
            value *= subjectNum
            value = value % divModifier
            loops += 1
        }
        return loops
    }
    
    func getEncryptKey(loopSize: Int, publicKey subjectNum: Int) -> Int {
        var value = 1
        for _ in 1...loopSize {
            value *= subjectNum
            value = value % divModifier
        }
        return value
    }
    
    func smashAndGrab() -> Int {
        var card: (publicKey: Int, loopSize: Int) = (data[0],-1)
        var door: (publicKey: Int, loopSize: Int) = (data[1],-1)
        
        card.loopSize = getLoopSize(target: card.publicKey)
        door.loopSize = getLoopSize(target: door.publicKey)
        
        return getEncryptKey(loopSize: card.loopSize, publicKey: door.publicKey)
    }

    func part1() -> Any {
        return smashAndGrab()
    }

    func part2() -> Any {
        return 0
    }
}


fileprivate let testInput = Data(raw: """
5764801
17807724
""")  // 14897079



