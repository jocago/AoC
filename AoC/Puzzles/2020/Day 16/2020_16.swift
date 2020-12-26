//
//  2020_16.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/22/20.
//


import Foundation
import SwifterSwift

struct p2020_16: Puzzle {
//    var data = testInput
//    var data = testInput2
    var data = input_2020_16
    var runPart = 2
    
    struct Rule {
        let type: String
        let range1: ClosedRange<Int>
        let range2: ClosedRange<Int>
        
        func allowedInEither(_ value: Int) -> Bool { range1.contains(value) || range2.contains(value) }
        func notAllowedInEither(_ value: Int) -> Bool { !allowedInEither(value) }
        
        init(type: String, range1: ClosedRange<Int>, range2: ClosedRange<Int>) {
            self.type = type
            self.range1 = range1
            self.range2 = range2
        }
        init(parseString: String) {
            // departure location: 50-688 or 707-966
            let splitz = parseString.split(separator: ":").map { String($0).trimmed }
            let rs = splitz[1].components(separatedBy: " or ").map { $0.split(separator: "-") }
            type = splitz[0]
            range1 = Int(rs[0][0])!...Int(rs[0][1])!
            range2 = Int(rs[1][0])!...Int(rs[1][1])!
        }
    }
    
    func parseData() -> (rules: [Rule], ticket: [Int], samples: [[Int]]) {
        var rules: [Rule] = []
        
        let blocks = data.raw.components(separatedBy: "\n\n").map {$0.trimmed}
        let ticket = blocks[1]
            .split(separator: ":")
            .map { String($0).trimmed }[1]
            .split(separator: ",")
            .map { Int($0)! }
        let samples = blocks[2]
            .split(separator: ":")[1]
            .split(separator: "\n")
            .map { $0.split(separator: ",") }
            .map { $0.map { Int($0)! } }
        for s in blocks[0].split(separator: "\n") {
            rules.append(Rule(parseString: String(s)))
        }
        return (rules, ticket, samples)
    }
    
    func getMostBad(badMatches: [Int: [String]], atMost: Int = Int.max) -> Int {
        var c = -1
        var cSlot = -1
        for slot in badMatches {
            let svc = slot.value.count
            if svc > c && svc <= atMost {
                c = svc
                cSlot = slot.key
            }
        }
        return cSlot
    }
    
    
    func part1() -> Any {
        let (rules, _, samples) = parseData()
        var badSums = 0
        for sampleTicket in samples {
            for val in sampleTicket {
                var ok = false
                for rule in rules {
                    if rule.allowedInEither(val) { ok = true }
                }
                if !ok { badSums += val }
            }
        }
        return badSums
    }

    func part2() -> Any {
        let keyword = "departure"
        let (rules, ticket , samples) = parseData()
        var notFieldPlace: [Int: [String]] = [:] // field place: types place cannot be
        let _ = (0..<ticket.count).map { notFieldPlace[$0] = [] }
        var tickets = samples.filter { ticket in
            ticket.contains { number in
                rules.allSatisfy { $0.allowedInEither(number) == false }
            } == false
        }
        tickets.append(ticket) // got to put my ticket in the testing bin
        for t in tickets {
            for i in 0..<t.count {  // ticket fields
                for r in rules {
                    if r.notAllowedInEither(t[i]) {
                        if !notFieldPlace[i]!.contains(r.type) {
                            notFieldPlace[i]!.append(r.type)
                        }
                    }
                }
            }
        }
        var fieldPlace: [String: Int] = [:]  // name of field: field place
        let fieldNames = rules.map { $0.type }
        var last = notFieldPlace.count - 1
        var orderOfBadFields: [Int] = []
        for _ in 0..<notFieldPlace.count {
            orderOfBadFields.append(getMostBad(badMatches: notFieldPlace, atMost: last))
            last -= 1
        }
        for num in orderOfBadFields {
            for field in fieldNames {
                if !fieldPlace.has(key: field) {
                    if !notFieldPlace[num]!.contains(field) {
                        fieldPlace[field] = num
                    }
                }
            }
        }
        let checkFields = fieldNames.filter { $0.starts(with: keyword) }
        var p = 1
        for field in checkFields {
            p *= ticket[fieldPlace[field]!]
        }
//        print(orderOfBadFields)
//        print(notFieldPlace)
//        print(fieldPlace)
//        print(fieldNames)
//        print(checkFields)
        return p
    }
}


fileprivate let testInput = Data(raw: """
class: 1-3 or 5-7
row: 6-11 or 33-44
seat: 13-40 or 45-50

your ticket:
7,1,14

nearby tickets:
7,3,47
40,4,50
55,2,20
38,6,12
""")  // 71

fileprivate let testInput2 = Data(raw: """
class: 0-1 or 4-19
row: 0-5 or 8-19
seat: 0-13 or 16-19

your ticket:
11,12,13

nearby tickets:
3,9,18
15,1,5
5,14,9
""")  // row, class, seat

