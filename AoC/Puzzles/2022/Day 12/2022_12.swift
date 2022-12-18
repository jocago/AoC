
import Foundation

struct p2022_12: Puzzle {
    //var data = testInput.parseToXYChar()
    var data = input_2022_12.parseToXYChar()
    var runPart = 2
    
    class Node: Hashable {
        let x: Int
        let y: Int
        var identifier: String { "\(x),\(y)" }
        let value: Character
        var numeric: Int { Int(self.value.asciiValue!) - 97 }
        var neighbours: [(Node, Double)] = []
        var pathLengthFromStart = Double.infinity
        var pathNodesFromStart: [Node] = []
        
        var hashValue: Int {
            return identifier.hashValue
        }
        
        static func ==(lhs: Node, rhs: Node) -> Bool {
                return lhs.hashValue == rhs.hashValue
            }

        init(x: Int, y: Int, value: Character) {
            self.value = value
            self.x = x
            self.y = y
        }

        func clearCache() {
            pathLengthFromStart = Double.infinity
            pathNodesFromStart = []
        }
        
        func getNeighborIdBlind(to heading: Heading) -> String {
            // does not asume result is a valid node
            var x = self.x
            var y = self.y
            switch heading {
            case .up:
                y -= 1
            case .right:
                x += 1
            case .down:
                y += 1
            case .left:
                x -= 1
            }
            return "\(x),\(y)"
        }
    }
    
    public class Heightmap {
        var nodes: Set<Node>
        let startID: String
        let endID: String

        public init(nodes: Set<Node>, startID: String, endID: String) {
            self.nodes = nodes
            self.startID = startID
            self.endID = endID
        }

        private func clearCache() {
            nodes.forEach { $0.clearCache() }
        }

        public func findShortestPaths(from startNode: Node) {
            clearCache()
            var unvisited = self.nodes
            startNode.pathLengthFromStart = 0
            startNode.pathNodesFromStart.append(startNode)
            var currentNode: Node? = startNode

            while let node = currentNode {
                unvisited.remove(node)
                let filteredNeighbours = node.neighbours.filter { unvisited.contains($0.0) }
                
                for neighbour in filteredNeighbours {
                    let neighbourNode = neighbour.0
                    let weight = neighbour.1
                    let theoreticNewWeight = node.pathLengthFromStart + weight

                    if theoreticNewWeight < neighbourNode.pathLengthFromStart {
                        neighbourNode.pathLengthFromStart = theoreticNewWeight
                        neighbourNode.pathNodesFromStart = node.pathNodesFromStart
                        neighbourNode.pathNodesFromStart.append(neighbourNode)
                    }
                }

                if unvisited.isEmpty {
                    currentNode = nil
                    break
                }
                currentNode = unvisited.min { $0.pathLengthFromStart < $1.pathLengthFromStart }
            }
        }
        
        func getNodeWith(id: String) -> Node? {
            return self.nodes.first { $0.identifier == id } ?? nil
        }
    }
    
    func parseMap() -> Heightmap {
        var nodes = Set<Node>()
        var startID: String = "-"
        var endID: String = "-"
        for (y,row) in data.enumerated() {
            for (x,col) in row.enumerated() {
                let id = "\(x),\(y)"
                var ch: Character = "-"
                if col == "S" {
                    ch = "a"
                    startID = id
                }
                else if col == "E" {
                    ch = "z"
                    endID = id
                } else { ch = col }
                nodes.insert(Node(x:x, y:y, value: ch))
            }
        }
        var hmap = Heightmap(nodes: nodes, startID: startID, endID: endID)
        // add paths/edges
        hmap.nodes.forEach { node in
            Heading.allCases.forEach { heading in
                let nID = node.getNeighborIdBlind(to: heading)
                if let dest = hmap.getNodeWith(id: nID) {
                    if dest.numeric - node.numeric < 2 {
                        // assuming a step up, across, or down are still 1 step
                        node.neighbours.append((dest,1))
                    }
                }
            }
        }
        
        return hmap
    }

    func part1() -> Any {
        let map = parseMap()
        map.findShortestPaths(from: map.getNodeWith(id: map.startID)!)
        return Int(map.getNodeWith(id: map.endID)!.pathLengthFromStart)
    }

    func part2() -> Any {
        let map = parseMap()
        var aPlaceHist: [(pId: String, dist: Int)] = []
        let aPlaces = map.nodes.filter { $0.value == "a" }
        let aPlacesCount = aPlaces.count
        print("\(aPlacesCount) \"a\" places found.")
        var i = 0
        var checks: [Float] = [0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]
        aPlaces.forEach { place in
            map.findShortestPaths(from: map.getNodeWith(id: place.identifier)!)
            if let dist = map.getNodeWith(id: map.endID)?.pathLengthFromStart {
                if dist.isNormal {
                    aPlaceHist.append((pId: place.identifier, dist: Int(dist)))
                }
                // this is just so I can see that it's running
                i += 1
                let pct = checks.first ?? 1.0
                if Float(i) / Float(aPlacesCount) >= pct {
                    print("\(pct * 100)% completed")
                    if !checks.isEmpty { checks.removeFirst() }
                }
            }
            
        }
        return aPlaceHist.min { $0.dist < $1.dist }!.dist
    }
}


/*
 Pt 1 test target: 31
 pt 2 test target: 29
 */
fileprivate let testInput = Data(raw: """
Sabqponm
abcryxxl
accszExk
acctuvwj
abdefghi
""")


