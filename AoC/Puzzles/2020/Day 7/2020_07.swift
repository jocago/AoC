//
//  2020_07.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/6/20.
//

import Foundation


struct p2020_7: Puzzle {
    //var data = testInput2.parseToStringArray(splitBy: ".")
    var data = input_2020_07.parseToStringArray(splitBy: ".")
    var runPart = 2
    
    let target = "shiny gold"
    
    class Bag: Hashable {
        let color: String
        var containedIn: [Bag] = []
        var contains: [Bag: Int] = [:]
        var countUp: Set<Bag> {
            Set(containedIn + containedIn.flatMap(\.countUp))
        }
        var countDown: Int {
            contains.reduce(into: 0) {
                $0 += (($1.key.countDown + 1) * $1.value)
            }
        }
        
        // required for Hashable protocol
        static func ==(lhs: Bag, rhs: Bag) -> Bool { lhs.color == rhs.color }
        func hash(into hasher: inout Hasher) { hasher.combine(color) }
        
        init(color: String) { self.color = color }
        
        func add(bag: Bag, count: Int) {
            bag.containedIn.insert(self, at: 0)
            contains[bag, default: 0] += count
        }
    }
    
    
    func parseRule(_ ruleString: String) -> [(String, Int)] {
        // first element is parent and subsequent elements are children of the parent
        var rules: [(String, Int)] = []
        
        
        var children: [String: Int] = [:]
        let ruleSegs = ruleString.replacingOccurrences(of: " bags contain ", with: "✂️")
            .split(separator: "✂️")
            .map { String($0) }
        let childrenT = ruleSegs[1].replacingOccurrences(of: ", ", with: "✂️")
            .split(separator: "✂️")
            .map { String($0) }
        for each in childrenT {
            if !each.contains("no other") {
                var bC = each.replacingOccurrences(of: "\n", with: "")
                bC = bC.replacingOccurrences(of: " bags", with: "")
                bC = bC.replacingOccurrences(of: " bag", with: "")
                let num = Int(String(bC.removeFirst()))!
                let _ = bC.removeFirst()
                children[String(bC)] = num
            }
        }
        if children.count > 0 {
            rules.append((ruleSegs[0].replacingOccurrences(of: "\n", with: ""),-1))
            for (k,v) in children {
                rules.append((k,v))
            }
        }
        return rules
    }
    
    func bagMe() -> [String: Bag] {
        var bags: [String: Bag] = [:]
        for rs in data {
            let ruleBlock = parseRule(rs) // [(color, count)]
            if ruleBlock.count > 0 { // why am I getting these?
                let (color, _) = ruleBlock[0]
                if !bags.has(key: color) { bags[color] = Bag(color: color) }
                let bag = bags[color]
                for (subColor, subCount) in ruleBlock[1..<ruleBlock.count] {
                    if !bags.has(key: subColor) { bags[subColor] = Bag(color: subColor) }
                    let subbag = bags[subColor]
                    bag!.add(bag: subbag!, count: subCount)
                }
                
            }
        }
        return bags
    }
    
    func part1() -> Any {
        let bags = bagMe()
        let target = bags["shiny gold"]!
        
        return target.countUp.count
    }


    func part2() -> Any {
        let bags = bagMe()
        let target = bags["shiny gold"]!
        
        return target.countDown
    }
}


fileprivate let testInput = Data(raw: """
light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.
""")

fileprivate let testInput2 = Data(raw: """
faded plum bags contain 5 wavy cyan bags.
dull aqua bags contain 4 dark fuchsia bags, 1 shiny purple bag.
dotted olive bags contain 1 striped gray bag.
vibrant brown bags contain 4 dark tan bags, 4 faded plum bags.
shiny gold bags contain 3 mirrored black bags.
dull bronze bags contain 2 plaid aqua bags, 4 shiny magenta bags, 2 faded green bags, 3 dotted gold bags.
wavy plum bags contain 5 dim indigo bags.
drab brown bags contain 5 clear fuchsia bags.
vibrant maroon bags contain 3 shiny coral bags, 1 dim indigo bag, 4 muted crimson bags, 5 clear black bags.
posh magenta bags contain no other bags.
dull brown bags contain 3 shiny gold bags, 3 striped silver bags, 1 shiny purple bag.
pale gray bags contain 3 plaid magenta bags, 3 clear teal bags, 3 pale white bags.
plaid turquoise bags contain 4 bright orange bags, 5 drab white bags, 4 dotted coral bags.
dotted silver bags contain 2 pale silver bags, 4 dark teal bags, 5 posh gold bags, 1 bright orange bag.
light red bags contain 1 dark violet bag, 1 mirrored coral bag, 3 drab tan bags, 4 muted olive bags.
shiny brown bags contain 5 vibrant lavender bags, 4 dark lavender bags.
plaid plum bags contain 1 faded green bag.
""")
