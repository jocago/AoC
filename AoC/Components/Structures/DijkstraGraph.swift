//
//  Graph.swift
//  AoC
//
//  Created by Joshua Gohlke on 1/2/22.
//

import Foundation

class DijkstraNode {
    var id:Point
    var distance:Int = Int.max
    var edges:[Point] = []
    var visited:Bool = false
    var weight:Int
    
    init(id: Point, weight: Int, edges: [Point]) {
     self.visited = false
     self.id = id
     self.weight = weight
     self.edges = edges
    }
    
    static func == (lhs: DijkstraNode, rhs: DijkstraNode) -> Bool {
     return lhs.id == rhs.id
    }
 }

class DijkstraGraph {
    var data:[[Int]]
    var nodes: [DijkstraNode] = []
    var width: Int
    var height: Int

    init(_ data: [[Int]]) {
        self.data = data
        width = data[0].count
        height = data.count
        
        for y in 0..<height {
            for x in 0..<width {
                let weight = data[Int(y % height)][Int(x % width)]
                let newNode = DijkstraNode(id: Point(x:x, y:y), weight: Int(weight), edges: [])
                self.nodes.append(newNode)
            }
        }

        for y in 0..<height {
            for x in 0..<width {
                let node = self.getNode(Point(x: x, y: y))

                if y - 1 > 0 { // up
                    node.edges.append(Point(x: x, y: y-1))
                }
                
                if x + 1 < width { // right
                    node.edges.append(Point(x: x+1, y: y))
                }
                
                if y + 1 < height { // down
                    node.edges.append(Point(x: x, y: y+1))
                }
                
                if x - 1 > 0 { // left
                    node.edges.append(Point(x: x-1, y: y))
                }
            }
        }
    }

    func getNode(_ point: Point) -> DijkstraNode {
        return nodes[point.y * width + point.x]
    }
    
    func getShortestPathWeight(from origin: Point, to dest: Point) -> Int {
        var trackerNode = self.getNode(origin)
        trackerNode.distance = 0
        
        var unvisited = [DijkstraNode]()
        unvisited.append(trackerNode)
        while (!unvisited.isEmpty) {
            unvisited = unvisited.filter{ $0.id != trackerNode.id }
            for edge in trackerNode.edges {
                let toNode = self.getNode(edge)
                let dist = trackerNode.distance + toNode.weight
                if (dist < toNode.distance) {
                    toNode.distance = dist
                    unvisited.append(toNode)
                }
            }
            if !unvisited.isEmpty {
                trackerNode = unvisited.min {$0.distance < $1.distance}!
            }
            if (trackerNode.id == dest) {
                return Int(trackerNode.distance)
            }
        }
        return -1
    }
    
}
