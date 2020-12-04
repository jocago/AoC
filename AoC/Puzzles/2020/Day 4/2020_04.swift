//
//  2020_04.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/3/20.
//


import Foundation
import SwifterSwift

/*
 A note about this very structured approach to a quick challenge problem: Errors made me do it.
 I had it all written as susinctly as I could make it, but my count just would not come out.
 After I broke everything out and could clearly follow the path, I found my error.
 Practice, practice, practice.
 */


struct Passport {
    // settings
    var verbose = true
    
    // base fields
    var byr: Int? // (Birth Year) - four digits; at least 1920 and at most 2002.
    var iyr: Int? // (Issue Year) - four digits; at least 2010 and at most 2020.
    var eyr: Int? // (Expiration Year) - four digits; at least 2020 and at most 2030.
    var hgt: String? // (Height) - a number followed by either cm or in:
            // If cm, the number must be at least 150 and at most 193.
            // If in, the number must be at least 59 and at most 76.
    var hcl: String? // (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
    var ecl: String? // (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
    var pid: String? // (Passport ID) - a nine-digit number, including leading zeroes.
    var cid: String? // (Country ID) - ignored, missing or not.s
    
    // advanced fields
    var hgt_n: Int? { // The numeric portion
        var tmp = hgt!
        guard tmp.count >= 3 else { return -1 }
        return Int(tmp.slice(from: 0, to: tmp.count - 2))
    }
    var hgt_m: Character? { // The measurement portion [n=inch,m=mm]
        return hgt?.last
    }
    var byrValidated: Bool {
        // four digits; at least 1920 and at most 2002.
        guard byr != nil else { return false }
        guard byr! >= 1920 && byr! <= 2002 else { return false }
        return true
    }
    var iyrValidated: Bool {
        //our digits; at least 2010 and at most 2020.
        guard iyr != nil else { return false }
        guard iyr! >= 2010 && iyr! <= 2020 else { return false }
        return true
    }
    var eyrValidated: Bool {
        // four digits; at least 2020 and at most 2030.
        guard eyr != nil else { return false }
        guard eyr! >= 2020 && eyr! <= 2030 else { return false }
        return true
    }
    var hgtValidated: Bool {
        // If cm, the number must be at least 150 and at most 193.
        // If in, the number must be at least 59 and at most 76.
        switch hgt_m {
        case "m": // cm
            guard hgt_n! >= 150 && hgt_n! <= 193 else { return false }
        case "n": // in
            guard hgt_n! >= 59 && hgt_n! <= 76 else { return false }
        default:
            return false
        }
        return true
    }
    var hclValidated: Bool {
        // a # followed by exactly six characters 0-9 or a-f.
        guard hcl != nil else { return false }
        var hclCh = hcl!.charactersArray
        guard hclCh.remove(at: 0) == "#" else { return false } // pops first and returns
        guard hclCh.count == 6 else { return false }
        let newStr = String(hclCh)
        let regRange = NSRange(location: 0, length: newStr.utf16.count)
        let regex = try! NSRegularExpression(pattern: "^[a-f0-9]*$")
        guard regex.firstMatch(in: newStr, options: [], range: regRange) != nil else { return false }
        return true
    }
    var eclValidated: Bool {
        // exactly one of: amb blu brn gry grn hzl oth.
        guard ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(ecl) else { return false }
        return true
    }
    var pidValidated: Bool {
        // a nine-digit number, including leading zeroes.
        guard pid != nil else { return false }
        guard pid!.count == 9 && pid!.isNumeric else { return false }
        return true
    }
    var cidValidated: Bool { return true }
    
    func isAllValid() -> Bool {
        if verbose {print("validations: ", terminator: "")}
        guard byrValidated else { if verbose {print()}; return false }
        if verbose {print("byr ", terminator: "")}
        guard iyrValidated else { if verbose {print()}; return false }
        if verbose {print("iyr ", terminator: "")}
        guard eyrValidated else { if verbose {print()}; return false }
        if verbose {print("eyr ", terminator: "")}
        guard hgtValidated else { if verbose {print()}; return false }
        if verbose {print("hgt ", terminator: "")}
        guard hclValidated else { if verbose {print()}; return false }
        if verbose {print("hcl ", terminator: "")}
        guard eclValidated else { if verbose {print()}; return false }
        if verbose {print("ecl ", terminator: "")}
        guard pidValidated else { if verbose {print()}; return false }
        if verbose {print("pid ", terminator: "")}
        guard cidValidated else { if verbose {print()}; return false }
        if verbose {print("cid ", terminator: "")}
        if verbose { print()}
        return true
    }
    
    
    init(id: String) {
        //if verbose { print(id) }
        let idT = id.split(separator: " ")
        for kv in idT {
            let kvp = kv.split(separator: ":")
            switch kvp[0] {
            case "byr":
                byr = Int(kvp[1]) ?? nil
            case "iyr":
                iyr = Int(kvp[1]) ?? nil
            case "eyr":
                eyr = Int(kvp[1]) ?? nil
            case "hgt":
                hgt = String(kvp[1])
            case "hcl":
                hcl = String(kvp[1])
            case "ecl":
                ecl = String(kvp[1])
            case "pid":
                pid = String(kvp[1])
            case "cid":
                cid = String(kvp[1])
            default:
                print("Not parsing the key: \(kvp[0])")
            }
        }
        
    }
    
    func getArrayOfAvailableFields() -> [String] {
        var ret: [String] = []
        if byr != nil { ret.append("byr") }
        if iyr != nil { ret.append("iyr") }
        if eyr != nil { ret.append("eyr") }
        if hgt != nil { ret.append("hgt") }
        if hcl != nil { ret.append("hcl") }
        if ecl != nil { ret.append("ecl") }
        if pid != nil { ret.append("pid") }
        if cid != nil { ret.append("cid") }
        
        return ret
    }
    
    func hasAllRequiredFields() -> Bool {
        let avail = getArrayOfAvailableFields()
        for field in ["byr","iyr","eyr","hgt","hcl","ecl","pid"] {
            if !avail.contains(field) { return false}
        }
        return true
    }
    
    
    
}


struct p2020_4: Puzzle {
    var data = input_2020_04.raw
    var runPart = 2
    
    func parseData() -> [String] {
        var  dataT = data.replacingOccurrences(of: "\n\n", with: "|")
        dataT = dataT.replacingOccurrences(of: "\n", with: " ")
        let dataArr = dataT.split(separator: "|")
        return dataArr.map { String($0) }
    }
    
    func part1() -> Any {
        return parseData().map { Passport(id: $0).hasAllRequiredFields() ? 1 : 0 }.reduce(0, +)
    }
    
    func part2() -> Any {
        return parseData().map { Passport(id: $0).isAllValid() ? 1 : 0 }.reduce(0, +)
    }
}

fileprivate let testInput = Data(raw: """
ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
byr:1937 iyr:2017 cid:147 hgt:183cm

iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
hcl:#cfa07d byr:1929

hcl:#ae17e1 iyr:2013
eyr:2024
ecl:brn pid:760753108 byr:1931
hgt:179cm

hcl:#cfa07d eyr:2025 pid:166559648
iyr:2011 ecl:brn hgt:59in
""")

