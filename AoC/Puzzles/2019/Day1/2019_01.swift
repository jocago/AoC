//
//  2019_01.swift
//  AoC
//
//  Created by Joshua Gohlke on 11/14/20.
//

import Foundation

struct p2019_01: Puzzle {
    var runPart = 2
    var data = input.parseToIntArray()
    var verbose = false
    
    
    mutating func replaceData(with data: [Int]) {
        self.data = data
    }
    
    func calculateFuel(forMass mass: Int) -> Int {
        return mass / 3 - 2
    }
    
    func part1() -> Any {
        var runningTotalFuel = 0
        for mass in data {
            runningTotalFuel += calculateFuel(forMass: mass)
        }
        return runningTotalFuel
    }
    
    func part2() -> Any {
        var runningTotalFuel: Int = 0 {
            didSet {
                if verbose {
                    print(runningTotalFuel)
                }
            }
        }
        
        func addAssign(_ amt: Int) -> Int {
            if amt > 0 {
                runningTotalFuel += amt
            }
            return amt
        }
        
        for mass in data {
            var massOfAddedFuel = addAssign(calculateFuel(forMass: mass))
            while massOfAddedFuel > 0 {
                massOfAddedFuel = addAssign(calculateFuel(forMass: massOfAddedFuel))
            }
        }
        return runningTotalFuel
    }
}



fileprivate let input = Data(raw: """
    71764
    58877
    107994
    72251
    74966
    87584
    118260
    144961
    86889
    136710
    52493
    131045
    101496
    124341
    71936
    88967
    106520
    125454
    113463
    81854
    99918
    105217
    120383
    61105
    103842
    125151
    139191
    143365
    102168
    69845
    57343
    93401
    140910
    121997
    107964
    53358
    57397
    141456
    94052
    127395
    99180
    143838
    130749
    126809
    70165
    92007
    83343
    55163
    95270
    101323
    99877
    105721
    129657
    61213
    130120
    108549
    90539
    111382
    61665
    95121
    53216
    103144
    134367
    101251
    105118
    73220
    56270
    50846
    77314
    59134
    98495
    113654
    89711
    68676
    98991
    109068
    129630
    58999
    132095
    98685
    91762
    88589
    73846
    124940
    106944
    133882
    104073
    78475
    76545
    144728
    72449
    118320
    65363
    83523
    124634
    96222
    128252
    112848
    139027
    108208
    """)
