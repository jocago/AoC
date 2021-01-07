//
//  2020_19.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/24/20.
//

import Foundation

struct p2020_19: Puzzle {
//    var data = testInput
    var data = input_2020_19
    var runPart = 2
    

    enum Rule {
        case path([Rule]) // the path a rule requires. Ex. 0: 4 1 5
        case route([Rule]) // the variations of routes a rule allows. Ex. 1: 2 3 | 3 2
        case pointer(Int) // a single value redirect. Ex. 10: 1
        case terminal(Character) // the final value that rules resolve to. Ex. 4: "a"

        init(line: String) {
            let path = line.components(separatedBy: " ")
            let route = line.components(separatedBy: " | ")
            if route.count >= 2 {
                self = .route(route.map { Rule(line: $0) })
            } else if path.count > 1 {
                self = .path(path.map { Rule(line: $0) })
            } else if let int = Int(line) {
                self = .pointer(int)
            } else {
                self = .terminal(Array(line)[1])
            }
        }



        func build(terms: [Character], rules: [Int: Rule]) -> [[Character]] {
            guard terms.count > 0 else { return [] }
            switch self {
            case .terminal(let tc):
                return tc == terms[0] ? [[tc]] : []
            case .path(let path):
                var matches: [[Character]] = [[]]
                for rule in path {
                    matches = matches.flatMap { match -> [[Character]] in
                        if match.count >= terms.count { return [] }
                        let ruleMatches = rule.build(terms: Array(terms[match.count..<terms.count]), rules: rules)
                        return ruleMatches.map { $0.count > 0 ? match + $0 : [] }
                    }
                }
                return matches
            case .route(let route): return route.reduce(into: [[Character]]()) { $0 += $1.build(terms: terms, rules: rules) }
            case .pointer(let i): return rules[i]!.build(terms: terms, rules: rules)
            }
        }

    }
    
    func parseData() -> ([Int : String], [String]) {
        let blocks = data.raw.components(separatedBy: "\n\n")
        guard blocks.count == 2 else { fatalError("Blocks did not split correctly: \(blocks)") }
        var ruleLines: [Int: String] = [:]
        for line in blocks[0].components(separatedBy: "\n").map({ String($0).components(separatedBy: ": ") }) {
            ruleLines[Int(line[0])!] = line[1]
        }
        let imageLines = blocks[1].components(separatedBy: "\n")

        return (ruleLines, imageLines)
    }
    
    func makeRules() -> ([Int : Rule], [[Character]]) {
        let (ruleLines, imageLines) = parseData()
        var rules: [Int: Rule] = [:]
        var imageStream: [[Character]] = []
        
        for line in ruleLines {
            rules[line.key] = Rule(line: line.value)
        }
        
        for line in imageLines {
            imageStream.append(line.charactersArray)
        }
        
        return (rules, imageStream)
    }

    func getMatches(rules: [Int : Rule], imageStream: [[Character]]) -> Any {
        let matching = imageStream.filter { message in
            rules[0]!.build(terms: message, rules: rules)
                .first { $0.count == message.count } != nil
        }
        return matching.count
    }
    
    func part1() -> Any {  //  239
        let (rules, imageStream) = makeRules()
        return getMatches(rules: rules, imageStream: imageStream)
    }

    func part2() -> Any {   //  405
        var (rules, imageStream) = makeRules()
        rules[8] = Rule.route([.pointer(42), .path([.pointer(42), .pointer(8)])])
        rules[11] = Rule.route([.path([.pointer(42), .pointer(31)]), .path([.pointer(42), .pointer(11), .pointer(31)])])
        return getMatches(rules: rules, imageStream: imageStream)
    }
}


fileprivate let testInput = Data(raw: """
0: 4 1 5
1: 2 3 | 3 2
2: 4 4 | 5 5
3: 4 5 | 5 4
4: "a"
5: "b"

ababbb
bababa
abbbab
aaabbb
aaaabbb
""")  //  2/2
