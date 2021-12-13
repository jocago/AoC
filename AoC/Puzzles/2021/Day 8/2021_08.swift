
import Foundation
import CryptoKit
import CoreMedia

struct p2021_8: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2021_8.parseToStringArray()
    var runPart = 2
    
    enum Space {
        case top, leftTop, rightTop, middle, leftBotom, rightBottm, bottom
    }
    
    struct Line {
        let samples: [String]
        let outputValues: [String]
        var digits:[Int:[Character]] = [:]
        var outputValue:Int = 0
        
        init(_ inp: String) {
            let segs = inp.replacingOccurrences(of: " | ", with: "|").split(separator: "|")
            samples = segs[0].split(separator: " ").map { String($0) }
            outputValues = segs[1].split(separator: " ").map { String($0) }
            scoobyDoo()
        }
        
        func countUniqueNumbers() -> Int {
            return outputValues.map{ $0.count }.filter{ [2,3,4,7].contains($0) }.count
        }
        
        private func getMissingElements(for arrFrom: [Character], from arrOf: [Character]) -> [Character] {
            var missingElements:[Character] = []
            for element in arrOf {
                if arrFrom.contains(element) == false { missingElements.append(element) }
            }
            return missingElements
        }
        
        mutating func scoobyDoo() {
            digits[1] = samples.filter{ $0.count == 2 }.first!.charactersArray.sorted()
            digits[7] = samples.filter{ $0.count == 3 }.first!.charactersArray.sorted()
            digits[4] = samples.filter{ $0.count == 4 }.first!.charactersArray.sorted()
            digits[8] = samples.filter{ $0.count == 7 }.first!.charactersArray.sorted()
            // group remaining digits by their component counts
            var len5 = samples.filter{ $0.count == 5 }.map{$0.charactersArray}
            var len6 = samples.filter{ $0.count == 6 }.map{$0.charactersArray}
            // first deal with len6
            // 4 is a subset of 9, but not of 0 or 6
            for i in 0..<len6.count {  // doing this the long way so I can use the iterator
                if getMissingElements(for: len6[i], from: digits[4]!).count == 0 {
                    digits[9] = len6.remove(at: i).sorted()
                    break
                }
            }
            // 1 is a subset of 0, but not of 6.
            for i in 0..<len6.count {  // doing this the long way so I can use the iterator
                if getMissingElements(for: len6[i], from: digits[1]!).count == 0 {
                    digits[0] = len6.remove(at: i).sorted()
                    break
                }
            }
            // leaving 6
            digits[6] = len6.remove(at: 0).sorted()
            // now the len5s
            // 1 is a subset of 3, but not of 2 or 5
            for i in 0..<len5.count {  // doing this the long way so I can use the iterator
                if getMissingElements(for: len5[i], from: digits[1]!).count == 0 {
                    digits[3] = len5.remove(at: i).sorted()
                    break
                }
            }
            // 5 is a subset of 9, but 2 is not
            for i in 0..<len5.count {  // doing this the long way so I can use the iterator
                if getMissingElements(for: digits[9]!, from: len5[i]).count == 0 {
                    digits[5] = len5.remove(at: i).sorted()
                    break
                }
            }
            // leaving 2
            digits[2] = len5.remove(at: 0).sorted()
            guard len5.isEmpty else { fatalError("The len5 group is not empty") }
            guard len6.isEmpty else { fatalError("The len6 group is not empty") }
            guard Set(digits.values).count == 10 else { fatalError("digits have duped-up") }
            
            // now find the output values
            var digitString = ""
            for val in outputValues.map({ $0.sorted() }) {
                for (k,v) in digits {
                    if val == v {
                        digitString.append(String(k))
                        break
                    }
                }
            }
            guard digitString.count == 4 else { fatalError("Number of digits is not right") }
            outputValue += Int(digitString)!
        }
        
    }
    
    func parseLines(_ inp: [String]) -> [Line] {
        var lines:[Line] = []
        for line in inp {
            lines.append(Line(line))
        }
        return lines
    }
    

    func part1() -> Any {
        let lines = parseLines(data)
        return lines.reduce(0, {$0 + $1.countUniqueNumbers()})
    }

    func part2() -> Any {
        let lines = parseLines(data)
        var runningTotal = 0
        for line in lines {
            //print(line.outputValue)
            runningTotal += line.outputValue
        }
        return runningTotal
    }
}


/*
 Pt 1 test target: 26
 pt 2 test target: 61229
 */
fileprivate let testInput = Data(raw: """
be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce
""")//8394,9781,1197,9361,4873,8418,4548,1625,8717,4315


