
import Foundation


struct p2021_12: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2021_12.parseToStringArray()
    var runPart = 2
    
    enum CaveSize { case small, big }

    struct Cave: Hashable, Equatable {
        func hash(into hasher: inout Hasher) {
            hasher.combine(name)
        }
        
        let name:String
        let isStartingCave:Bool
        let isEndingCave:Bool
        let caveSize:CaveSize
        
        init(name:String) {
            self.name = name
            self.isStartingCave = name == "start"
            self.isEndingCave = name == "end"
            self.caveSize = name.allSatisfy { $0.isLowercase } ? .small : .big
        }
    }

    struct Path {
        var path:[Cave] = []
        var visitedCounts:[Cave: Int] = [:]
        var numSmallCavesVisitedTwice = 0
        var lastVisited:Cave = Cave(name: "placeholder")
        
        mutating func tryToAdd(cave: Cave) {
            path.append(cave)
            lastVisited = cave

            if cave.caveSize == .small && visitedCounts[cave] != nil {
                numSmallCavesVisitedTwice += 1
            }
            visitedCounts[cave, default: 0] += 1
        }
    }

    struct CaveMap {
        func allowedToVisit(cave: Cave, in path: Path, expandVisitation:Bool) -> Bool {
            if cave.caveSize == .small {
                if expandVisitation {
                    if path.visitedCounts[cave, default: 0] == 0 {
                        return true
                    } else {
                        return path.numSmallCavesVisitedTwice < 1
                    }
                } else {
                    return !(path.visitedCounts[cave] != nil)
                }
            } else {
                return true
            }
        }
    }

    struct CavePaths {
        let ExitsTo:[Cave: [Cave]]
        let expandedVisitation:Bool

        init(rules:[String], expandVisitation:Bool) {
            var exits:[Cave:[Cave]] = [:]

            for rule in rules {
                // this is a super handy way that several people used.
                let caves = rule.components(separatedBy: "-").map(Cave.init)
                exits[caves[0], default: []].append(caves[1])
                exits[caves[1], default: []].append(caves[0])
            }

            self.ExitsTo = exits
            self.expandedVisitation = expandVisitation
        }

        func getPaths() -> [Path] {
            let startingCave = Cave(name: "start")
            var startingPath = Path()
            startingPath.tryToAdd(cave: startingCave)

            var finishedPaths:[Path] = []

            var paths:[Path] = []
            paths.append(startingPath)
            while !paths.isEmpty {
                let currentPath = paths.removeFirst()

                for neighbor in self.ExitsTo[currentPath.lastVisited, default: []] {
                    if neighbor.isStartingCave {
                        continue
                    }
                    let caveMap = CaveMap()
                    if !caveMap.allowedToVisit(cave:neighbor, in:currentPath, expandVisitation:expandedVisitation) {
                        continue
                    }

                    var newPath = currentPath
                    newPath.tryToAdd(cave: neighbor)
                    if neighbor.isEndingCave {
                        finishedPaths.append(newPath)
                    } else {
                        paths.append(newPath)
                    }
                }
            }

            return finishedPaths
        }
    }


    func part1() -> Any {
        let pathMap = CavePaths(rules: data, expandVisitation: false)
        return pathMap.getPaths().count
    }

    func part2() -> Any {
        let pathMap = CavePaths(rules: data, expandVisitation: true)
        return pathMap.getPaths().count
    }
}


/*
 Pt 1 test target: 226
 pt 2 test target: 3509
 */
fileprivate let testInput = Data(raw: """
fs-end
he-DX
fs-he
start-DX
pj-DX
end-zg
zg-sl
zg-pj
pj-he
RW-he
fs-DX
pj-RW
zg-RW
start-pj
he-WI
zg-he
pj-fs
start-RW
""")


