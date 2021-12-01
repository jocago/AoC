//
//  2020_20.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/27/20.
//

// Not Finished

import Foundation



struct p2020_20: Puzzle {
    var data = testInput.parseToBlockOfStringsArray()
    var runPart = 1
    
    enum Facing {
        case obverse, reverse
    }
    
    enum Heading {
        case w, a, s, d
        /* After trying to re-read some past code,
         I really need to stop trying to be cute with my names */
    }

    struct Tile {
        let id: Int
        let contents: [String]
        let facing: Facing = .obverse
        let headed: Heading = .w
        
        func getEdge(heading: Heading, facing: Facing) -> String {
            var tmpTile: [String] = []
            switch facing {
            case .obverse:
                tmpTile = contents
            case .reverse:
                tmpTile = contents.map { String($0.reversed()) }
            }
            switch heading {
            case .w: return tmpTile.first!
            case .a: return String(tmpTile.compactMap(\.first))
            case .s: return tmpTile.last!
            case .d: return String(tmpTile.compactMap(\.last))
            }
        }
        
        
    }
    
    func createTiles() -> [Tile] {
        var tiles: [Tile] = []
        for block in data {
            let id = Int(block[0].getSubString(start: 6, stop: 9))!
            tiles.append(Tile(id: id, contents: Array(block[1...])))
        }
        return tiles
    }
    

    func part1() -> Any {
        var tiles = createTiles()
        print(tiles.map {$0.id})
        return 0
    }

    func part2() -> Any {
        return 0
    }
}


fileprivate let testInput = Data(raw: """
Tile 2311:
..##.#..#.
##..#.....
#...##..#.
####.#...#
##.##.###.
##...#.###
.#.#.#..##
..#....#..
###...#.#.
..###..###

Tile 1951:
#.##...##.
#.####...#
.....#..##
#...######
.##.#....#
.###.#####
###.##.##.
.###....#.
..#.#..#.#
#...##.#..

Tile 1171:
####...##.
#..##.#..#
##.#..#.#.
.###.####.
..###.####
.##....##.
.#...####.
#.##.####.
####..#...
.....##...

Tile 1427:
###.##.#..
.#..#.##..
.#.##.#..#
#.#.#.##.#
....#...##
...##..##.
...#.#####
.#.####.#.
..#..###.#
..##.#..#.

Tile 1489:
##.#.#....
..##...#..
.##..##...
..#...#...
#####...#.
#..#.#.#.#
...#.#.#..
##.#...##.
..##.##.##
###.##.#..

Tile 2473:
#....####.
#..#.##...
#.##..#...
######.#.#
.#...#.#.#
.#########
.###.#..#.
########.#
##...##.#.
..###.#.#.

Tile 2971:
..#.#....#
#...###...
#.#.###...
##.##..#..
.#####..##
.#..####.#
#..#.#..#.
..####.###
..#.#.###.
...#.#.#.#

Tile 2729:
...#.#.#.#
####.#....
..#.#.....
....#..#.#
.##..##.#.
.#.####...
####.#.#..
##.####...
##..#.##..
#.##...##.

Tile 3079:
#.#.#####.
.#..######
..#.......
######....
####.#..#.
.#...#.##.
#.#####.##
..#.###...
..#.......
..#.###...
""")  //  20899048083289


