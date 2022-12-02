
import Foundation

struct p2022_2: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2022_2.parseToStringArray()
    var runPart = 2

    func part1() -> Any {
        var total = 0
        
        data.forEach {
            let instr = $0.split(separator: " ")
            var win_value = 0
            var play_value = 0
            if instr[1] == "X" {
                play_value += 1
                if instr[0] == "A" { win_value += 3 }
                else if instr[0] == "C" { win_value += 6 }
            } else if instr[1] == "Y" {
                play_value += 2
                if instr[0] == "A" { win_value += 6 }
                else if instr[0] == "B" { win_value += 3}
            } else if instr[1] == "Z" {
                play_value += 3
                if instr[0] == "B" { win_value += 6}
                else if instr[0] == "C" { win_value += 3 }
            }
            total += win_value + play_value
        }
        
        return total
    }

    func part2() -> Any {
        var total = 0
        
        data.forEach {
            let instr = $0.split(separator: " ")
            var win_value = 0
            var play_value = 0
            if instr[0] == "A" { // Rock
                if instr[1] == "X" { // Scisors
                    play_value += 3
                } else if instr[1] == "Y" { // Rock
                    play_value += 1
                    win_value += 3
                } else {  // Paper
                    play_value += 2
                    win_value += 6
                }
            } else if instr[0] == "B" { //Paper
                if instr[1] == "X" { // Rock
                    play_value += 1
                } else if instr[1] == "Y" { // Paper
                    play_value += 2
                    win_value += 3
                } else { // Scisors
                    play_value += 3
                    win_value += 6
                }
            } else { // Scisors
                if instr[1] == "X" { // Paper
                    play_value += 2
                } else if instr[1] == "Y" { // Scisors
                    play_value += 3
                    win_value += 3
                } else { // Rock
                    play_value += 1
                    win_value += 6
                }
            }
            total += win_value + play_value
        }
        
        return total
    }
}


/*
 Pt 1 test target: ?
 pt 2 test target: ?
 */
fileprivate let testInput = Data(raw: """
A Y
B X
C Z
""")


