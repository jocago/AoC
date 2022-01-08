
import Foundation

struct p2021_14: Puzzle {
    //var data = testInput.parseToBlocksArray()
    var data = input_2021_14.parseToBlocksArray()
    var runPart = 2
    
    struct Pair:Hashable {
        let lhs:Character
        let rhs:Character
    }

    struct PairInsertionRule {
        let pair:Pair
        let insertChar:Character
    }

    struct RuleChain {
        var rules: [Pair: Character] = [:]

        init(rules: [PairInsertionRule]) {
            for rule in rules {
                self.rules[rule.pair] = rule.insertChar
            }
        }

        func polymerize(_ polymer: String, numTimes: Int) -> Int {
            let polyArr = polymer.charactersArray
            var charCounts:[Character:Int] = [:]
            var pairCounts:[Pair:Int] = [:]
            
            for polyChar in polyArr {
                charCounts[polyChar, default: 0] += 1
            }

            for pair in polyArr.windows(ofCount: 2).map({ Array($0) }) {
                pairCounts[Pair(lhs: pair[0], rhs: pair[1]), default: 0] += 1
            }
            
            for _ in 1...numTimes {
                var tmpPairCounts:[Pair: Int] = [:]

                for (pair,count) in pairCounts {
                    let insertChar = rules[pair]!
                    let newL = Pair(lhs: pair.lhs, rhs: insertChar)
                    let newR = Pair(lhs: insertChar, rhs: pair.rhs)

                    tmpPairCounts[newL, default: 0] += pairCounts[pair]!
                    tmpPairCounts[newR, default: 0] += pairCounts[pair]!
                    charCounts[insertChar, default: 0] += count
                }
                pairCounts = tmpPairCounts
            }

            return charCounts.values.max()! - charCounts.values.min()!
        }
    }
    
    func createRule(from inp: String) -> PairInsertionRule {
        let strCmps = inp.components(separatedBy: " -> ")
        let pairChars = strCmps[0].charactersArray
        let pairRule = PairInsertionRule(pair: Pair(lhs: pairChars[0], rhs: pairChars[1]),
                                         insertChar: Array(strCmps[1])[0])
        return pairRule
    }

    
    func part1() -> Any {
        let polymer = data[0]
        let rules = data[1].split(separator: "\n").map({String($0)}).map({createRule(from: $0)})
        return RuleChain(rules: rules).polymerize(polymer, numTimes: 10)
    }

    func part2() -> Any {
        let polymerTemplate = data[0]
        let rules = data[1].split(separator: "\n").map({String($0)}).map({createRule(from: $0)})
        return RuleChain(rules: rules).polymerize(polymerTemplate, numTimes: 40)
    }
}


/*
 Pt 1 test target: 1588
 pt 2 test target: 2188189693529
 */
fileprivate let testInput = Data(raw: """
NNCB

CH -> B
HH -> N
CB -> H
NH -> C
HB -> C
HC -> B
HN -> C
NN -> C
BH -> H
NC -> B
NB -> B
BN -> B
BB -> N
BC -> B
CC -> N
CN -> C
""")


