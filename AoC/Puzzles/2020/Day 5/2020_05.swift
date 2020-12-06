//
//  2020_05.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/4/20.
//

import Foundation
import SwifterSwift

/*
 Wow this one is ugly. Not the problem. It's a fun one.
 But I think I went through the most basic trail and error way to find the solution possible.
 I will probably come back and clean this up a bit when I'm not so tired.
 */

struct p2020_5: Puzzle {
    var data = input_2020_05.parseToStringArray()
    var runPart = 2
    let maxRow = 127 // 0 indexed
    let maxCol = 7 // 0 indexed
    
    func findSeatFrom(space: String) -> (Int, Int) {
        // Return the [row,col] of seat
        let dirs = space.charactersArray
        var rowMin = 0
        var rowMax = maxRow
        var colMin = 0
        var colMax = maxCol
        for i in 0..<7 {
            let midVal = Int(round(Double(rowMax - rowMin) / 2.0))
            switch dirs[i] {
            case "B":
                rowMin += midVal
            case "F":
                rowMax -= midVal
            default:
                print("Value \(dirs[i]) should be either B or F")
            }
        }
            guard rowMin == rowMax else { return (-1, 0) }  // Error: the math for finding the row is broken
        for i in 7..<10 {
            let midVal = Int(round(Double(colMax - colMin) / 2.0))
            switch dirs[i] {
            case "R":
                colMin += midVal
            case "L":
                colMax -= midVal
            default:
                print("Value \(dirs[i]) should be either R or L")
            }
        }
        guard colMin == colMax else { return (-2, 0) }  // Error: the math for finding the col is broken
        
        return (rowMin, colMin)
    }

    func part1() -> Any {
        var maxSeatId = Int.min
        for seat in data {
            let (rowNum, colNum) = findSeatFrom(space: seat)
            let seatId = rowNum * 8 + colNum
            if seatId > maxSeatId { maxSeatId = seatId}
        }
        return maxSeatId
    }

    func part2() -> Any {
        var seats: [Int] = []
        var availSeats: [Int]  = []
        var missingSeats: [Int] = []
        for i in 0..<128 {
            for j in 0..<8 {
                availSeats.append(i * 8 + j)
            }
        }
        for seat in data {
            let (rowNum, colNum) = findSeatFrom(space: seat)
            seats.append(rowNum * 8 + colNum)
        }
        seats.sort()
        for a in availSeats {
            if !seats.contains(a) {
                missingSeats.append(a)
            }
        }
        var candidates: [Int] = []
        for c in missingSeats {
            if c >= seats.min()! && c <= seats.max()! { candidates.append(c) }
        }
        if candidates.count == 1 { return candidates[0] }
        print(candidates)
        return 0
    }
}


fileprivate let testInput = Data(raw: """
FBFBBFFRLR
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL
""")
