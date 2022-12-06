
import Foundation

struct p2022_3: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2022_3.parseToStringArray()
    var runPart = 2
    
    func get_priority(for charVal: Int) -> Int {
        return charVal > 96 ? charVal - 96 : charVal - 38
    }

    func part1() -> Any {
        var priorities = 0
        for rucksack in data {
            let half = Int(exactly: rucksack.count / 2)!
            let comp1 = rucksack.getSubString(start: 1, stop: half).charactersArray
            let comp2 = rucksack.getSubString(start: half + 1, stop: rucksack.count).charactersArray
            let commonItem = comp1.filter { item in comp2.contains(item) }
            priorities += get_priority(for: Int(commonItem[0].asciiValue!))
            
        }
        return priorities
    }

    func part2() -> Any {
        var priorities = 0
        var i = 0
        while i < data.count {
            let rucksack1 = data[i].charactersArray
            let rucksack2 = data[i+1].charactersArray
            let rucksack3 = data[i+2].charactersArray
            var commonItem = Character("A")
            for item in rucksack1 {
                if rucksack2.contains(item) && rucksack3.contains(item) {
                    commonItem = item
                }
            }
            priorities += get_priority(for: Int(commonItem.asciiValue!))
            i += 3
        }
        return priorities
    }
}


/*
 Pt 1 test target: 157
 pt 2 test target: 70
 */
fileprivate let testInput = Data(raw: """
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw
""")


