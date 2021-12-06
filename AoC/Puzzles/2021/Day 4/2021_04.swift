
import Foundation

struct p2021_4: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2021_4.parseToStringArray()
    var runPart = 2
    
    func matricize(_ inp: [String]) -> [[[Int]]] {
        var blocks:[[[Int]]] = []
        var rowIdx = 0
        var blockTmp: [[Int]] = []
        var rowTmp: [Int] = []
        for row in inp {
            let row = row.replacingOccurrences(of: "  ", with: " ")
            for col in row.split(separator: " ").map({ Int(String($0))! }) {
                rowTmp.append(col)
            }
            blockTmp.append(rowTmp)
            rowTmp = []
            
            if rowIdx == 4 {  // dump block into current blocks
                blocks.append(blockTmp)
                blockTmp = []
                rowIdx = 0
            } else {
                rowIdx += 1
            }
        }
        return blocks
    }
    
    func checkForBingo(hits: [(Int, Int)]) -> Bool {
        guard hits.count >= 5 else { return false }
        var x:[Int:Int] = [0:0,1:0,2:0,3:0,4:0]
        var y:[Int:Int] = [0:0,1:0,2:0,3:0,4:0]
        for hit in hits {
            x[hit.0]! += 1
            y[hit.1]! += 1
        }
        let xR = x.filter { $0.value >= 5 }
        if xR.count >= 1 { return true }
        let yR = y.filter { $0.value >= 5 }
        if yR.count >= 1 { return true}
        return false
    }
    
    func sumBoard(_ board: [[Int]]) -> Int {
        var val = 0
        for r in board {
            for c in r {
                val += c
            }
        }
        return val
    }
    
    

    func part1() -> Any {
        let calls:[Int] = data[0].split(separator: ",").map { Int(String($0))! }
        var boards: [[[Int]]] = matricize(data[1...].map({String($0)}))
        var hits: [[(Int, Int)]] = Array.init(repeating: [], count: boards.count)
        var callHist:[Int] = []
        
        for call in calls {
            callHist.append(call)
            for b in 0..<boards.count {
                for r in 0...4 {
                    for c in 0...4 {
                        if call == boards[b][r][c] {
                            hits[b].append((r,c))
                        }
                    }
                }
                if checkForBingo(hits: hits[b]) {
                    // bingo
                    for x in 0...4 {
                        for y in 0...4 {
                            if callHist.contains(boards[b][x][y]) {
                                boards[b][x][y] = 0
                            }
                        }
                    }
                    return sumBoard(boards[b]) * call
                }
            }
        }
        return 0
    }

    func part2() -> Any {
        let calls:[Int] = data[0].split(separator: ",").map { Int(String($0))! }
        var boards: [[[Int]]] = matricize(data[1...].map({String($0)}))
        var hits: [[(Int, Int)]] = Array.init(repeating: [], count: boards.count)
        var callHist:[Int] = []
        var boardHist:[Int] = []

        
        for call in calls {
            callHist.append(call)
            for b in 0..<boards.count {
                for r in 0...4 {
                    for c in 0...4 {
                        if call == boards[b][r][c] {
                            hits[b].append((r,c))
                        }
                    }
                }
                if checkForBingo(hits: hits[b]) {
                    // bingo
                    if boards.count == boardHist.count {
                        for x in 0...4 {
                            for y in 0...4 {
                                let bLast = boardHist.last!
                                if callHist.contains(boards[bLast][x][y]) {
                                    boards[bLast][x][y] = 0
                                }
                            }
                        }
                        return sumBoard(boards[boardHist.last!]) * call
                    } else {
                        if !boardHist.contains(b) {
                            boardHist.append(b)
                        }
                    }
                }
            }
        }
        return 0
    }
}


fileprivate let testInput = Data(raw: """
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
""")


