
import Foundation

fileprivate extension Substring {
    mutating func popFirst(_ count: Int) -> Self {
        let result = self.prefix(count)
        self = self.dropFirst(count)
        return result
    }
}

//fileprivate protocol Element {
//    var magnatude: Int { get }
//}
//
//extension Element:  where number: Int {
//    var number: Int { get }
//}

struct p2021_18: Puzzle {
    //var data = testInput//.parseToStringArray()
    var data = input_2021_18//.parseToStringArray()
    var runPart = 2
    
    // MARK: REDUX
    
//    enum Side { case left,right }
//
//    struct RegularNumber: Element {
//        let number: Int
//        let side: Side
//        var magnatude: Int { number * (side == .left ? 3 : 2) }
//        var needsToSplit: Bool { number > 9 }
//
//        fileprivate func split() -> PairNumber {
//            let num: Double = Double(number)
//            let left = Int(floor(num / 2))
//            let right = Int(ceil(num / 2))
//            return PairNumber(lhs: RegularNumber(number: left, side: .left),
//                              rhs: RegularNumber(number: right, side: .right))
//        }
//    }
//
//    fileprivate struct PairNumber: Element {
//        let lhs: Element
//        let rhs: Element
//        var magnatude: Int { lhs.magnatude + rhs.magnatude }
//
//        init(_ inp:String) {
//            let sides = inp.components(separatedBy: ",")
//            let left: Element
//            let right: Element
//            if let leftE = Int(sides[0]) {
//                left = RegularNumber(number: leftE, side: .left)
//            } else {
//                left = PairNumber(sides[0])
//            }
//            if let rightE = Int(sides[1]) {
//                right = RegularNumber(number: rightE, side: .right)
//            } else {
//                right = PairNumber(sides[1])
//            }
//            self.init(lhs:left, rhs:right)
//        }
//
//        init(lhs:Element, rhs:Element) {
//            self.lhs = lhs
//            self.rhs = rhs
//        }
//
//        func explode() -> (left:Int, right:Int) {
//            guard type(of: lhs) == RegularNumber else {
//                fatalError("Left value is not an regular number")
//            }
//            guard type(of: rhs) == RegularNumber else {
//                fatalError("Right value is not an regular number")
//            }
//            return (lhs.number,rhs.number)
//        }
//    }

    // MARK: ORIGINAL
    
    indirect enum Snailfish: Equatable {
        case value(Int)
        case snailfish(SnailfishPair)

        var description: String {
            switch self {
            case .value(let value): return value.description
            case .snailfish(let snailfish): return snailfish.description
            }
        }

        var magnitude: Int {
            switch self {
            case .value(let value): return value
            case .snailfish(let snailfish): return snailfish.magnitude
            }
        }

        var copy: Self {
            switch self {
            case .value: return self
            case .snailfish(let snailfish): return .snailfish(snailfish.copy)
            }
        }
    }

    final class SnailfishPair: NSObject {
        var left: Snailfish {
            didSet {
                if case .snailfish(let nestedPair) = left {
                    nestedPair.parent = self
                }
            }
        }
        var right: Snailfish {
            didSet {
                if case .snailfish(let nestedPair) = right {
                    nestedPair.parent = self
                }
            }
        }

        weak var parent: SnailfishPair?

        var level: Int {
            guard let parent = parent else { return 0 }
            return parent.level + 1
        }

        init(left: Snailfish, right: Snailfish) {
            self.left = left
            self.right = right

            super.init()

            if case .snailfish(let nestedPair) = left {
                nestedPair.parent = self
            }
            if case .snailfish(let nestedPair) = right {
                nestedPair.parent = self
            }
        }

        override var description: String {
            return "[\(left.description),\(right.description)]"
        }

        var copy: SnailfishPair {
            SnailfishPair(left: left.copy, right: right.copy)
        }

        var magnitude: Int {
            3 * left.magnitude + 2 * right.magnitude
        }

        var hasLiteralValue: Bool {
            if case .value = left {
                return true
            }
            if case .value = right {
                return true
            }
            return false
        }

        var inorder: [SnailfishPair] {
            var leftInOrder: [SnailfishPair] {
                if case .snailfish(let pair) = left {
                    return pair.inorder
                }
                return []
            }

            var rightInOrder: [SnailfishPair] {
                if case .snailfish(let pair) = right {
                    return pair.inorder
                }

                return []
            }

            return leftInOrder + [self] + rightInOrder
        }
    }

    func parse(_ input: inout Substring) -> SnailfishPair {
        input.removeFirst()

        var left: Snailfish
        if input.first == "[" {
            left = .snailfish(parse(&input))
        } else {
            var number = 0
            while input.first!.isWholeNumber {
                number *= 10
                number += input.removeFirst().wholeNumberValue!
            }
            left = .value(number)
        }

        input.removeFirst()

        var right: Snailfish
        if input.first == "[" {
            right = .snailfish(parse(&input))
        } else {
            var number = 0
            while input.first!.isWholeNumber {
                number *= 10
                number += input.removeFirst().wholeNumberValue!
            }
            right = .value(number)
        }

        input.removeFirst()

        return SnailfishPair(left: left, right: right)
    }

    func explode(_ pair: SnailfishPair, in root: SnailfishPair) -> Bool {
        guard
            pair.level >= 4,
            case .value(let leftValue) = pair.left,
            case .value(let rightValue) = pair.right
            else { return false }

        let allNodes = root.inorder
        if let next = allNodes.drop(while: { $0 != pair }).dropFirst().first(where: { $0.hasLiteralValue }) {
            if case .value(let value) = next.left { next.left = .value(value + rightValue) }
            else if case .value(let value) = next.right { next.right = .value(value + rightValue) }
        }
        if let previous = allNodes.reversed().drop(while: { $0 != pair }).dropFirst().first(where: { $0.hasLiteralValue }) {
            if case .value(let value) = previous.right { previous.right = .value(value + leftValue) }
            else if case .value(let value) = previous.left { previous.left = .value(value + leftValue) }
        }

        if case .snailfish(pair) = pair.parent?.left {
            pair.parent?.left = .value(0)
        } else {
            pair.parent?.right = .value(0)
        }
        return true
    }

    func split(_ pair: SnailfishPair) -> Bool {
        if case .value(let value) = pair.left, value >= 10 {
            pair.left = .snailfish(
                SnailfishPair(
                    left: .value(Int((Double(value) / 2).rounded(.down))),
                    right: .value(Int((Double(value) / 2).rounded(.up)))
                )
            )
            return true
        } else if case .value(let value) = pair.right, value >= 10 {
            pair.right = .snailfish(
                SnailfishPair(
                    left: .value(Int((Double(value) / 2).rounded(.down))),
                    right: .value(Int((Double(value) / 2).rounded(.up)))
                )
            )
            return true
        }
        return false
    }

    func reduce(_ root: SnailfishPair) -> Bool {
        for pair in root.inorder {
            if explode(pair, in: root) {
                return true
            }
        }

        for pair in root.inorder {
            if split(pair) {
                return true
            }
        }

        return false
    }

    func fullyReduce(_ root: SnailfishPair) {
        while(reduce(root)) {}
    }



    func part1() -> Any {
        var inputSubstring = data.raw.split(separator: "\n")[0]
        var root = parse(&inputSubstring)
        fullyReduce(root)

        for line in data.raw.split(separator: "\n").dropFirst() {
            var copy = line
            let newRule = parse(&copy)
            root = SnailfishPair(left: .snailfish(root), right: .snailfish(newRule))
            fullyReduce(root)
        }

        return root.magnitude.description
//        return 0
    }

    func part2() -> Any {
        let snailfishes = data.raw
            .split(separator: "\n")
            .map { line -> SnailfishPair in
                var copy = line
                return parse(&copy)
            }

        var maxMagnitude = Int.min

        for snailfish in snailfishes {
            for other in snailfishes {
                guard snailfish != other else { continue }
                let root = SnailfishPair(left: .snailfish(snailfish.copy), right: .snailfish(other.copy))
                fullyReduce(root)
                maxMagnitude = max(maxMagnitude, root.magnitude)
            }
        }

        return maxMagnitude.description
//        return 0
    }
}


/*
 Pt 1 test target: [[[[6,6],[7,6]],[[7,7],[7,0]]],[[[7,7],[7,7]],[[7,8],[9,9]]]] - 4140
 pt 2 test target: [[[[7,8],[6,6]],[[6,0],[7,7]]],[[[7,8],[8,8]],[[7,9],[0,6]]]] - 3993
 */
fileprivate let testInput = Data(raw: """
[[[0,[5,8]],[[1,7],[9,6]]],[[4,[1,2]],[[1,4],2]]]
[[[5,[2,8]],4],[5,[[9,9],0]]]
[6,[[[6,2],[5,6]],[[7,6],[4,7]]]]
[[[6,[0,7]],[0,9]],[4,[9,[9,0]]]]
[[[7,[6,4]],[3,[1,3]]],[[[5,5],1],9]]
[[6,[[7,3],[3,2]]],[[[3,8],[5,7]],4]]
[[[[5,4],[7,7]],8],[[8,3],8]]
[[9,3],[[9,9],[6,[4,9]]]]
[[2,[[7,7],7]],[[5,8],[[9,3],[0,2]]]]
[[[[5,2],5],[8,[3,7]]],[[5,[7,5]],[4,4]]]
""")


