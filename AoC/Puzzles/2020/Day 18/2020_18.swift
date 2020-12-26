//
//  2020_18.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/23/20.
//


import Foundation


struct p2020_18: Puzzle {
//    var data = testInput1.parseToStringArray()
//    var data = testInput2.parseToStringArray()
//    var data = testInput3.parseToStringArray()
//    var data = testInput4.parseToStringArray()
//    var data = testInput5.parseToStringArray()
    var data = input_2020_18.parseToStringArray()
    var runPart = 2
    
    func calc(_ inp: String, orderSumFirst: Bool) -> String {
        /*
            1. select the parentheticals and recursively calc those
            2. select first pair of nums and recursively calc those
            3. Calc pair of nums and return value
        */
        guard inp.count(of: "+") > 0 || inp.count(of: "*") > 0 else { return inp }
        if inp.contains("(") { // break into parentheticals
            var strC = inp.charactersArray
            // find the first inner-most set of parens
            var rangeT: (lower: Int, upper: Int) = (0,0)
            for i in 0..<strC.count {
                
                if strC[i] == "(" { rangeT.lower = i }
                else if strC[i] == ")" {
                    rangeT.upper = i
                    break
                }
            }
            let range = ClosedRange(uncheckedBounds: rangeT)
            let newStr = strC[range].map { String($0) }.reduce("",+)
            // replace
            let resp = calc(newStr.dropFirstAndLast(), orderSumFirst: orderSumFirst) //Replace str
            strC.replaceSubrange(range, with: resp.charactersArray)
            return calc(strC.map { String($0) }.reduce("",+), orderSumFirst: orderSumFirst)
        } else { // calc the nums with ops [+,*]
            var strC = inp.charactersArray
            var num1: (lower: Int, upper: Int) = (0,-1)
            var op: (lower: Int, upper: Int) = (-1,-1)
            var num2: (lower: Int, upper: Int) = (-1,-1)
            // 1) find first viable op
            var i = 0
            var pattern: [Character] = ["+"]
            if !orderSumFirst || !strC.contains("+") { pattern.append("*") }
            while !pattern.contains(strC[i]) { i += 1 }
            op.lower = i
            op.upper = i
            num1.upper = i - 1
            num2.lower = i + 1
            // 2) back up until we get to the prior op or the beginning
            i -= 1
            while !["+","*"].contains(strC[i]) {
                guard i - 1 >= 0 else {
                    i -= 1  // take an extra to give back below
                    break
                }
                i -= 1
            }
            num1.lower = i + 1  // give one back to get beyond the newfound op
            // 3) go forward from op until we get the next op or the end
            i = op.upper + 1
            while !["+","*"].contains(strC[i]) {
                guard i + 1 < strC.count else {
                    i += 1  // give an extra to take back below
                    break
                }
                i += 1
            }
            num2.upper = i - 1  // take one back to get beyond the newfound op
            // 4) calc vals
            let num1Range = ClosedRange(uncheckedBounds: num1)
            let opRange = ClosedRange(uncheckedBounds: op)
            let num2Range = ClosedRange(uncheckedBounds: num2)
            let n1 = String(strC[num1Range])
            let o = String(strC[opRange])
            let n2 = String(strC[num2Range])
            var resp: Int
            if o == "+" { resp = Int(n1)! + Int(n2)! }
            else { resp = Int(n1)! * Int(n2)! }
            let fullRange = ClosedRange(uncheckedBounds: (num1Range.lowerBound, num2Range.upperBound))
            strC.replaceSubrange(fullRange, with: String(resp).charactersArray)
            return calc(strC.map { String($0) }.reduce("",+), orderSumFirst: orderSumFirst)
        }
    }

    func part1() -> Any {
        return data.map { Int(calc($0.filter { $0 != " " }, orderSumFirst: false ))! }.reduce(0,+)
    }

    func part2() -> Any {
        return data.map { Int(calc($0.filter { $0 != " " }, orderSumFirst: true ))! }.reduce(0,+)
    }
}


fileprivate let testInput1 = Data(raw: """
1 + (2 * 3) + (4 * (5 + 6))
""") // 51/51

fileprivate let testInput2 = Data(raw: """
2 * 3 + (4 * 5)
""") // 26/46

fileprivate let testInput3 = Data(raw: """
5 + (8 * 3 + 9 + 3 * 4 * 3)
""") // 437/1445

fileprivate let testInput4 = Data(raw: """
5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))
""") // 12240/669060

fileprivate let testInput5 = Data(raw: """
((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2
""") // 13632/23340



