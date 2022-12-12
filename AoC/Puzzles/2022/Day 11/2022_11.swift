
import Foundation

struct p2022_11: Puzzle {
    //var data = testInput.parseToBlocksArray()
    var data = input_2022_11.parseToBlocksArray()
    var runPart = 2
    var verbose = false
        
    struct Item {
        let id = UUID().uuidString
        var worryHistory: [Int] = []
        var currentWorry: Int { get { worryHistory.last ?? -999 } }
        
        init(worry: Int) {
            self.worryHistory.append(worry)
        }
        
        mutating func newWorry(_ worry: Int) {
            self.worryHistory.append(worry)
        }
        
        func getHistory() -> [Int] { worryHistory }
    }
    
    struct Monkey {
        let id: Int
        var inventory: [Item] = []
        var inspections = 0
        let operation: (op: Character, by: Int)
        let div: Int
        let passFailTarget: (pass: Int, fail: Int)
        
        mutating func pop() -> Item {
            return inventory.removeFirst()
        }
        
        mutating func add(item: Item) {
            inventory.append(item)
        }
        
        mutating func inspect() {
            inspections += 1
        }
        
    }
    
    func parseInput(data: [String]) -> [Monkey] {
        ///
        /// I was really mixed about which way to go with this input. On the one had, the format sucks. A lot.
        /// But it's structured, in a way. Every record has a format that does not change so I wanted to
        /// create a parsing block rather than hard code the data. In the end, I think I would have saved about
        /// half my time by just hard coding the data. I should have done that for this specific use case.
        ///
        var monkeys: [Monkey] = []
        data.forEach { block in
            let monkeyNum: Int
            var itemsNums: [Item] = []
            let operation: (op: Character, by: Int)
            let div: Int
            let passFailTarget: (pass: Int, fail: Int)
            
            let lines = block.split(separator: "\n")
            // monkey id
            monkeyNum = Int(String(lines[0][offset: 7]))!
            // items
            let itemsString = String(lines[1].split(separator: ":")[1]).trimmed
            let items = itemsString.split(separator: ",").map { Int(String($0).trimmed)! }
            items.forEach { item in
                itemsNums.append(Item(worry: item))
            }
            // ops
            var tLineA = lines[2].split(separator: " ").map { String($0) }
            let by: Int
            if tLineA.last == "old" {
                by = -99
                let _ = tLineA.popLast()!
            }
            else { by = Int(tLineA.popLast()!)! }
            let op: Character = tLineA.last == "*" ? "*" : "+"
            operation = (op: op, by: by)
            // test/div
            let dLineA = lines[3].split(separator: " ").map { String($0) }
            div = Int(dLineA.last!)!
            // pass/fail
            let pass = Int(lines[4].split(separator: " ").map { String($0) }.last!)!
            let fail = Int(lines[5].split(separator: " ").map { String($0) }.last!)!
            passFailTarget = (pass: pass, fail: fail)
            // monkey
            var monkey = Monkey(id: monkeyNum,
                                operation: operation,
                                div: div,
                                passFailTarget: passFailTarget)
            itemsNums.forEach { item in
                monkey.add(item: item)
            }
            monkeys.append(monkey)
        }
        return monkeys
    }
    
    func monkeyInTheMiddle(tresimateWorry: Bool, roundsToReview: Int) -> Int {
        var monkeys = parseInput(data: data)
        let rounds = 1...roundsToReview
        for round in rounds {
            monkeys.forEach { monkey in
                if verbose {
                    let monkeyID = monkey.id
                    print("Monkey \(monkeyID):")
                }
                
                while monkeys[monkey.id].inventory.count > 0 {
                    var item = monkeys[monkey.id].inventory.removeFirst()
                    if verbose {
                        let ind = String(repeating: " ", count: 2)
                        print("\(ind)Monkey inspects an item with a worry level of \(item.currentWorry).")
                    }
                    monkeys[monkey.id].inspect()
                    var inspectWorry: Int
                    if monkey.operation.op == "*" {
                        let m = monkey.operation.by == -99 ? item.currentWorry : monkey.operation.by
                        inspectWorry = item.currentWorry * m
                        if verbose {
                            let ind = String(repeating: " ", count: 4)
                            print("\(ind)Worry level is multiplied by \(m) to \(inspectWorry).")
                        }
                    } else {
                        inspectWorry = item.currentWorry + monkey.operation.by
                        if verbose {
                            let ind = String(repeating: " ", count: 4)
                            print("\(ind)Worry level increases by \(monkey.operation.by) to \(inspectWorry).")
                        }
                    }
                    if tresimateWorry {
                        item.newWorry(Int(floor(Double(inspectWorry) / 3.0)))
                    } else {
                        let gcd = monkeys.map { $0.div }.reduce(1, *)
                        inspectWorry %= gcd
                        item.newWorry(inspectWorry)
                    }
                    
                    if verbose {
                        let ind = String(repeating: " ", count: 4)
                        print("\(ind)Monkey gets bored with item. Worry level is divided by 3 to \(item.currentWorry).")
                    }
                    // now throw it to another monkey
                    let test = item.currentWorry % monkey.div == 0
                    if test {
                        monkeys[monkey.passFailTarget.pass].add(item: item)
                        if verbose {
                            let ind = String(repeating: " ", count: 4)
                            print("\(ind)Current worry level is divisible by \(monkey.div).")
                            print("\(ind)Item with worry level \(item.currentWorry) is thrown to monkey \(monkey.passFailTarget.pass).")
                        }
                    } else {
                        monkeys[monkey.passFailTarget.fail].add(item: item)
                        if verbose {
                            let ind = String(repeating: " ", count: 4)
                            print("\(ind)Current worry level is not divisible by \(monkey.div).")
                            print("\(ind)Item with worry level \(item.currentWorry) is thrown to monkey \(monkey.passFailTarget.fail).")
                            
                        }
                    }
                }
            }
            if verbose {
                print("Round \(round)")
                monkeys.forEach { monkey in
                    var things: [Int] = []
                    monkey.inventory.forEach { things.append($0.currentWorry) }
                    print("Monkey \(monkey.id): \(things)")
                }
            }
            
        }
        let smonkeys = monkeys.sorted { $0.inspections > $1.inspections }
        return smonkeys[0].inspections * smonkeys[1].inspections
    }
    
    

    func part1() -> Any {
        return monkeyInTheMiddle(tresimateWorry: true, roundsToReview: 20)
    }

    func part2() -> Any {
        return monkeyInTheMiddle(tresimateWorry: false, roundsToReview: 10_000)
    }
}


/*
 Pt 1 test target: 10605
 pt 2 test target: ?
 */
fileprivate let testInput = Data(raw: """
Monkey 0:
  Starting items: 79, 98
  Operation: new = old * 19
  Test: divisible by 23
    If true: throw to monkey 2
    If false: throw to monkey 3

Monkey 1:
  Starting items: 54, 65, 75, 74
  Operation: new = old + 6
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 0

Monkey 2:
  Starting items: 79, 60, 97
  Operation: new = old * old
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 3:
  Starting items: 74
  Operation: new = old + 3
  Test: divisible by 17
    If true: throw to monkey 0
    If false: throw to monkey 1
""")


