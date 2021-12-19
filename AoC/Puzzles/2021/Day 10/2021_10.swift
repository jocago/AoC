
import Foundation

struct p2021_10: Puzzle {
    //var data = testInput.parseToStringArray().map { $0.charactersArray }
    var data = input_2021_10.parseToStringArray().map { $0.charactersArray }
    var runPart = 2
    
    let openings:[Character] = ["(","[","{","<"]
    let closings:[Character] = [")","]","}",">"]
    let ErrorValues:[Int] = [3,57,1197,25137]
    let completionValues:[Int] = [1,2,3,4]
    
    func runRules(rules: [[Character]], returnErrors: Bool) -> Int {
        var illegals = 0
        var completions:[Int] = []
        for line in data {
            var stack:[Int] = []
            var lineValid = true
            for cha in line {
                if openings.contains(cha) {
                    stack.append(openings.firstIndex(of: cha)!)
                } else if cha != closings[stack.popLast()!] {
                    illegals += ErrorValues[closings.firstIndex(of: cha)!]
                    lineValid = false
                    break
                }
            }
            if lineValid {
                var completion = 0
                for _ in 0..<stack.count {
                    completion *= 5
                    completion += completionValues[stack.popLast()!]
                }
                completions.append(completion)
            }
        }
        
        return returnErrors ? illegals : completions.sorted()[completions.count / 2]
    }
    

    func part1() -> Any {
        return runRules(rules: data, returnErrors: true)
    }

    func part2() -> Any {
        return runRules(rules: data, returnErrors: false)
    }
}


/*
 Pt 1 test target: 26397
 pt 2 test target: 288957
 */
fileprivate let testInput = Data(raw: """
[({(<(())[]>[[{[]{<()<>>
[(()[<>])]({[<{<<[]>>(
{([(<{}[<>[]}>{[]{[(<()>
(((({<>}<{<{<>}{[]{[]{}
[[<[([]))<([[{}[[()]]]
[{[{({}]{}}([{[{{{}}([]
{<[[]]>}<{[{[{[]{()[[[]
[<(<(<(<{}))><([]([]()
<{([([[(<>()){}]>(<<{{
<{([{{}}[<[[[<>{}]]]>[]]
""")


