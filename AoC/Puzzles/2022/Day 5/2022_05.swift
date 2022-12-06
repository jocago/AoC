
import Foundation

struct p2022_5: Puzzle {
    //var data = testInput.parseToStringArray()
    //var stacksNum = 3
    //var stacksStop = 3
    var data = input_2022_5.parseToStringArray()
    var stacksNum = 9
    var stacksStop = 8
    var runPart = 2
    
    func getStacks() -> [[Character]] {
        var stacks: [[Character]] = Array(repeating: [Character](), count: stacksNum)
        for d in (0..<stacksStop).reversed() {
            var curr = 1
            for s in 0..<stacksNum {
                if curr < data[d].count {
                    let chars = data[d].charactersArray
                    let char = chars[curr]
                    if char.isLetter { stacks[s].append(char) }
                    curr += 4
                } else { break }
            }
        }
        return stacks
    }
    
    func getInstructions() -> [(num: Int, from: Int, to: Int)] {
        var instrs: [(num: Int, from: Int, to: Int)] = []
        for d in (stacksStop+1)..<data.count {
            let row = data[d].split(separator: " ")
            instrs.append((num: Int(row[1])!, from: Int(row[3])!, to: Int(row[5])!))
        }
        return instrs
    }

    func part1() -> Any {
        var stacks = getStacks()
        let instrs = getInstructions()
        instrs.forEach { instr in
            for _ in 0..<instr.num {
                stacks[instr.to-1].append(stacks[instr.from-1].popLast()!)
            }
        }
        var tops: [Character] = []
        stacks.forEach { stack in tops.append(stack.last!) }
        return String(tops)
    }

    func part2() -> Any {
        var stacks = getStacks()
        let instrs = getInstructions()
        instrs.forEach { instr in
            var tmpStack: [Character] = []
            for _ in 0..<instr.num {
                tmpStack.append(stacks[instr.from-1].popLast()!)
            }
            stacks[instr.to-1].append(contentsOf: tmpStack.reversed())
        }
        var tops: [Character] = []
        stacks.forEach { stack in tops.append(stack.last!) }
        return String(tops)
    }
}


/*
 Pt 1 test target: CMZ
 pt 2 test target: MCD
 */
fileprivate let testInput = Data(raw: """
    [D]
[N] [C]
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
""")


