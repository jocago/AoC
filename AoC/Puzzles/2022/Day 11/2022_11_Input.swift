//
//  2021_05_Input.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/5/21.
//

let input_2022_11 = Data(raw: """
Monkey 0:
  Starting items: 64
  Operation: new = old * 7
  Test: divisible by 13
    If true: throw to monkey 1
    If false: throw to monkey 3

Monkey 1:
  Starting items: 60, 84, 84, 65
  Operation: new = old + 7
  Test: divisible by 19
    If true: throw to monkey 2
    If false: throw to monkey 7

Monkey 2:
  Starting items: 52, 67, 74, 88, 51, 61
  Operation: new = old * 3
  Test: divisible by 5
    If true: throw to monkey 5
    If false: throw to monkey 7

Monkey 3:
  Starting items: 67, 72
  Operation: new = old + 3
  Test: divisible by 2
    If true: throw to monkey 1
    If false: throw to monkey 2

Monkey 4:
  Starting items: 80, 79, 58, 77, 68, 74, 98, 64
  Operation: new = old * old
  Test: divisible by 17
    If true: throw to monkey 6
    If false: throw to monkey 0

Monkey 5:
  Starting items: 62, 53, 61, 89, 86
  Operation: new = old + 8
  Test: divisible by 11
    If true: throw to monkey 4
    If false: throw to monkey 6

Monkey 6:
  Starting items: 86, 89, 82
  Operation: new = old + 2
  Test: divisible by 7
    If true: throw to monkey 3
    If false: throw to monkey 0

Monkey 7:
  Starting items: 92, 81, 70, 96, 69, 84, 83
  Operation: new = old + 4
  Test: divisible by 3
    If true: throw to monkey 4
    If false: throw to monkey 5
""")
