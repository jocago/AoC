
import Foundation

struct p2021_3: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2021_3.parseToStringArray()
    var runPart = 2
    
    func mostCommonBits(arr: [String]) -> ([Int], [Int]) {
        let num_elements = data[0].count
        var zero: [Int] = Array.init(repeating: 0, count: num_elements)
        var one: [Int] = Array.init(repeating: 0, count: num_elements)
        
        for rec in arr {
            let rec_a = rec.charactersArray
            for i in 0..<num_elements {
                if rec_a[i] == "0" { zero[i] += 1 }
                else { one[i] += 1 }
            }
        }
        
        return (zero, one)
    }
    
    func bin2int(_ inp: String) -> Int {
        Int(strtoul(inp, nil, 2))
    }

    func part1() -> Any {
        var gamma: [Int] = []
        var epsilon: [Int] = []
        let num_elements = data[0].count
        let (zero, one) = mostCommonBits(arr: data)
        
        for i in 0..<num_elements {
            if zero[i] > one[i] {
                gamma.append(0)
                epsilon.append(1)
            } else {
                gamma.append(1)
                epsilon.append(0)
            }
        }
        
        let epsilonNum = bin2int(epsilon.map({String($0)}).joined())
        let gammaNum = bin2int(gamma.map({String($0)}).joined())
        return  epsilonNum * gammaNum
    }

    func part2() -> Any {
        
        // oxygen
        var dataTmp = data
        var i = 0
        while dataTmp.count > 1{
            //print("\n\(dataTmp)")
            let (zero, one) = mostCommonBits(arr: dataTmp)
            //print(zero, one)
            var filter: Character
            if one[i] >= zero[i] {
                // ith bit should be 1
                filter = "1"
            } else {
                // ith bit should be 0
                filter = "0"
            }
            var tmp: [String] = []
            for row in dataTmp {
                let rowT = row.charactersArray
                if rowT[i] == filter {
                    tmp.append(row)
                }
            }
            dataTmp = tmp
            i += 1
        }
        let oxygen = dataTmp[0]
        
        // c02
        dataTmp = data
        i = 0
        while dataTmp.count > 1{
            //print("\n\(dataTmp)")
            let (zero, one) = mostCommonBits(arr: dataTmp)
            //print(zero, one)
            var filter: Character
            if zero[i] <= one[i] {
                // ith bit should be 0
                filter = "0"
            } else {
                // ith bit should be 1
                filter = "1"
            }
            var tmp: [String] = []
            for row in dataTmp {
                let rowT = row.charactersArray
                if rowT[i] == filter {
                    tmp.append(row)
                }
            }
            dataTmp = tmp
            i += 1
        }
        let c02 = dataTmp[0]
        
        print(oxygen, c02)
        return bin2int(oxygen) * bin2int(c02)
    }
}


fileprivate let testInput = Data(raw: """
00100
11110
10110
10111
10101
01111
00111
11100
10000
11001
00010
01010
""")

