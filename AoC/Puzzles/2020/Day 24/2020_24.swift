//
//  2020_24.swift
//  AoC
//
//  Created by Joshua Gohlke on 1/7/21.
//

import Foundation

struct p2020_24: Puzzle {
    var data = testInput.parseToStringArray()
    var runPart = 1
    
    func parse(line: String) -> [String] {
        // e, se, sw, w, nw, and ne
        var commands: [String] = []
        let chop = line.charactersArray
        var i = 0
        while i < chop.count {
            switch chop[i] {
            case "e","w":
                commands.append(String(chop[i]))
                i += 1
            default: // 2 char code
                let one = chop[i]
                i += 1
                let two = chop[i]
                commands.append(String([one,two]))
                i += 1
            }
        }
        return commands
    }

    func part1() -> Any {
        print(data.map { parse(line: $0) })
        return 0
    }

    func part2() -> Any {
        return 0
    }
}


fileprivate let testInput = Data(raw: """
sesenwnenenewseeswwswswwnenewsewsw
neeenesenwnwwswnenewnwwsewnenwseswesw
seswneswswsenwwnwse
nwnwneseeswswnenewneswwnewseswneseene
swweswneswnenwsewnwneneseenw
eesenwseswswnenwswnwnwsewwnwsene
sewnenenenesenwsewnenwwwse
wenwwweseeeweswwwnwwe
wsweesenenewnwwnwsenewsenwwsesesenwne
neeswseenwwswnwswswnw
nenwswwsewswnenenewsenwsenwnesesenew
enewnwewneswsewnwswenweswnenwsenwsw
sweneswneswneneenwnewenewwneswswnese
swwesenesewenwneswnwwneseswwne
enesenwswwswneneswsenwnewswseenwsese
wnwnesenesenenwwnenwsewesewsesesew
nenewswnwewswnenesenwnesewesw
eneswnwswnwsenenwnwnwwseeswneewsenese
neswnwewnwnwseenwseesewsenwsweewe
wseweeenwnesenwwwswnew
""")  // 10
