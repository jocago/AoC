
import Foundation
import SwiftGraph


struct p2021_15: Puzzle {
    //var data = testInput.parseToXYInt()
    var data = testInput2.parseToXYInt()
    //var data = input_2021_15.parseToXYInt()
    var runPart = 1
    
    
    struct Chiton:Encodable,Decodable,Equatable,CustomStringConvertible {
        let x:Int
        let y:Int
        var description:String { "\(x)*\(y)" }
        var idx = -1
    }

    func part1() -> Any {
        var caveMap = Matrix(data)
        var chitons:[Chiton] = []
        for x in 0..<(caveMap.width) {
            for y in 0..<caveMap.height {
                let xy = Chiton(x:x,y:y)
                //xy.idx = x + y*10
                //print(xy.idx)
                chitons.append(xy)
            }
        }
        let Cave = WeightedGraph<String, Int>(vertices: chitons.map { $0.description })
        for chiton in chitons {
            let xOk = chiton.x < caveMap.width - 1
            let yOk = chiton.y < caveMap.height - 1
            // assume positive movements. May need to include negatives, too
            let xy = "\(chiton.x)*\(chiton.y)"
//            if xOk && yOk { chitonGraph.addEdge(from: xy,
//                                                 to: "\(node.x + 1)*\(node.y + 1)",
//                                                 weight:data[node.x + 1][node.y + 1]) }
            if xOk { Cave.addEdge(from: xy,
                                          to: "\(chiton.x + 1)*\(chiton.y)",
                                          weight:data[chiton.x + 1][chiton.y]) }
            if yOk { Cave.addEdge(from: xy,
                                          to: "\(chiton.x)*\(chiton.y + 1)",
                                          weight:data[chiton.x][chiton.y + 1]) }
        }
        let (_, pathDict) = Cave.dijkstra(root: "0*0", startDistance: 0)
        let path: [WeightedEdge<Int>] = pathDictToPath(from: Cave.indexOfVertex("0*0")!,
                                                       to: Cave.indexOfVertex("\(caveMap.width - 1)*\(caveMap.height - 1)")!,
                                                       pathDict: pathDict)
        path.forEach { step in
            print(step)
        }
        return totalWeight(path)! // > 355
    }

    func part2() -> Any {
        return 0
    }
}


/*
 Pt 1 test target: 40
 pt 2 test target: ?
 */
fileprivate let testInput = Data(raw: """
1163751742
1381373672
2136511328
3694931569
7463417111
1319128137
1359912421
3125421639
1293138521
2311944581
""")

fileprivate let testInput2 = Data(raw:"""
19999
19111
11191
""")


