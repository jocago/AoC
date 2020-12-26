//
//  2020_13.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/18/20.
//


import Foundation

struct p2020_13: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2020_13.parseToStringArray()
    var runPart = 2

    func part1() -> Any {
        let currentTime = Int(data[0])!
        var bestBus = 0
        var bestBusLeaves = Int.max
        
        for bus in data[1].split(separator: ",") {
            if bus != "x" {
                let bus = Int(bus)!
                var i = 0
                while i * bus < currentTime { i += 1 }
                let nextTime = i * bus
                if nextTime < bestBusLeaves {
                    bestBusLeaves = nextTime
                    bestBus = bus
                }
            }
        }
        
        return bestBus * (bestBusLeaves - currentTime)
    }

//    func part2() -> Any {
//        // original is not efficient enough. Runs forever.
//
//        var schedule: [UInt64] = []
//        let _ = data[1].split(separator: ",").map {schedule.append($0 == "x" ? 0 : UInt64(String($0))!)}
//        var ts: UInt64 = schedule[0]
//
//        while true {
//            var match = true
//            for i in 1..<schedule.count {
//                if schedule[i] != 0 {
//                    if (ts + UInt64(i)) % schedule[i] != 0 {
//                        ts += schedule[0]
//                        match = false
//                        break
//                    }
//                }
//
//            }
//            if match { break }
//        }
//        return ts
//    }
    
    func part2() -> Any {
        let schedule = data[1].split(separator: ",").map { Int($0) ?? 1 }
        var ts = schedule[0]
        var incr = schedule[0]
        var i = 1
        while i < schedule.count {
            if (ts + i) % schedule[i] == 0 {
                incr *= schedule[i]
                i += 1
            } else {
                ts += incr
            }
        }
        return ts
    }
}


fileprivate let testInput = Data(raw: """
939
7,13,x,x,59,x,31,19
""")



