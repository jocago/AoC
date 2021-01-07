//
//  Input.swift
//  AoC
//
//  Created by Joshua Gohlke on 11/14/20.
//

import Foundation

protocol Input {
    var raw: String { get }
}

extension Input {
    func parseToIntArray(splitBy: Character = "\n") -> [Int] {
        return raw.split(separator: splitBy).map { Int($0)! }
    }
    func parseToStringArray(splitBy: Character = "\n") -> [String] {
        return raw.split(separator: splitBy).map { String($0) }
    }
    
    
    /**
     Creates a two-deep array of strings based on input where each line is an element and groups are delineated by empty lines.
     
     Using  the defualt ✂️ as a charcter indicates an empty line which creates the outer group.
     
     As an example,
     a
     
     b
     c
     would be broken into two groups, [[a],[b,c]]
     */
    func parseToDeepStringArray(splitBy: Character = "✂️", splitAgainBy: Character = "\n") -> [[String]] {
        var s = raw
        if splitBy == "✂️" { s = s.replacingOccurrences(of: "\n\n", with: "✂️") }
        let splitOuter = s.split(separator: splitBy).map { String($0) }
        var splits: [[String]] = []
        for each in splitOuter {
            let tmpArr = each.split(separator: splitAgainBy)
            let tmpArrS = tmpArr.map {  String($0)  }
            splits.append(tmpArrS)
        }
        return splits
    }
    
    /**
     Creates a string array based on input where each line is an element and groups are delineated by empty lines. However, the individual elements are concatenated so that the inner array is flattened.
     
     Using  the defualt ✂️ as a charcter indicates an empty line which creates the groups.
     Ignoring character will be removed.
     As an example,
     a
     
     b
     c
     would be broken into two elements, [a,bc]
     */
    func parseToFlattenedStringArray(splitBy: Character = "✂️", ignoring: Character = "\n") -> [String] {
        var s = raw
        if splitBy == "✂️" { s = s.replacingOccurrences(of: "\n\n", with: "✂️") }
        let dataT = s.replacingOccurrences(of: String(ignoring), with: "")
        let dataArr = dataT.split(separator: splitBy)
        return dataArr.map { String($0) }
    }
    
    func parseToBlocksArray() -> [String] {
        return raw.components(separatedBy: "\n\n").map { String($0) }
    }
    
    func parseToBlockOfStringsArray() -> [[String]] {
        return raw.components(separatedBy: "\n\n").map { String($0) }.map { $0.components(separatedBy: "\n") }
    }
}

struct Data: Input {
    var raw: String
}
