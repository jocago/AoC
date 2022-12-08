
import Foundation

struct p2022_8: Puzzle {
    //var data = testInput.parseToXYInt()
    var data = input_2022_8.parseToXYInt()
    var runPart = 2
    
    enum ScoreScheme { case edge, tree }
    
    func isGoodTree(cTree: Point, tTree: Point) -> (isGood: Bool, score: Int) {
        // target tree is in-bounds
        guard tTree.x >= 0 else { return (isGood: false, score:0) }
        guard tTree.x < data[0].count else { return (isGood: false, score:0) }
        guard tTree.y >= 0 else { return (isGood: false, score:0) }
        guard tTree.y < data.count else { return (isGood: false, score:0) }
        // target tree is not too tall
        guard data[tTree.y][tTree.x] < data[cTree.y][cTree.x] else { return (isGood: false, score: 1) }
        return (isGood: true, score: 1)
    }

    func getDirectionScore(cTree: Point, dir: Heading, scoreScheme: ScoreScheme) -> Int {
        var tTree = Point(x: cTree.x, y: cTree.y)
        var score = 0
        var go = true
        while go {
            switch dir {
            case .up:
                tTree.moveInYAxis(by: -1)
            case .right:
                tTree.moveInXAxis(by: 1)
            case .down:
                tTree.moveInYAxis(by: 1)
            case .left:
                tTree.moveInXAxis(by: -1)
            }
            let result = isGoodTree(cTree: cTree, tTree: tTree)
            score += result.score
            if !result.isGood { go = false }
        }
        if scoreScheme == .tree { return score }
        else if scoreScheme == .edge {
            if tTree.x < 0 || tTree.x >= data[0].count { return 1 }
            else if tTree.y < 0 || tTree.y >= data.count { return 1 }
            return 0
        }
        else { return -1 }
    }
    
    func part1() -> Any {
        let wide = data[0].count
        let tall = data.count
        var trees: [(x: Int, y: Int, n: Int, e: Int, s: Int, w: Int, t: Int)] = []
        for y in 0..<tall {
            for x in 0..<wide {
                let cPoint = Point(x: x, y: y)
                let n = self.getDirectionScore(cTree: cPoint, dir: .up, scoreScheme: .edge)
                let e = self.getDirectionScore(cTree: cPoint, dir: .right, scoreScheme: .edge)
                let s = self.getDirectionScore(cTree: cPoint, dir: .down, scoreScheme: .edge)
                let w = self.getDirectionScore(cTree: cPoint, dir: .left, scoreScheme: .edge)
                let t = max(n,e,s,w)
                trees.append((x: x, y: y, n: n, e: e, s: s, w: w, t: t))
            }
        }
        return trees.reduce(0) { $0 + $1.t }
    }
    
    func part2() -> Any {
        let wide = data[0].count
        let tall = data.count
        var trees: [(x: Int, y: Int, n: Int, e: Int, s: Int, w: Int, t: Int)] = []
        for y in 0..<tall {
            for x in 0..<wide {
                let cPoint = Point(x: x, y: y)
                let n = self.getDirectionScore(cTree: cPoint, dir: .up, scoreScheme: .tree)
                let e = self.getDirectionScore(cTree: cPoint, dir: .right, scoreScheme: .tree)
                let s = self.getDirectionScore(cTree: cPoint, dir: .down, scoreScheme: .tree)
                let w = self.getDirectionScore(cTree: cPoint, dir: .left, scoreScheme: .tree)
                let t = n * e * s * w
                trees.append((x: x, y: y, n: n, e: e, s: s, w: w, t: t))
            }
        }
        return trees.sorted { $0.t < $1.t }.last!.t
    }
}


/*
 Pt 1 test target: 21
 pt 2 test target: 8
 */
fileprivate let testInput = Data(raw: """
30373
25512
65332
33549
35390
""")


