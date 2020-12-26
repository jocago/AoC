//
//  2020_22.swift
//  AoC
//
//  Created by Joshua Gohlke on 12/25/20.
//


import Foundation

struct p2020_22: Puzzle {
//    var data = testInput
    var data = input_2020_22
    var runPart = 2
    
    func deal() -> ([Int], [Int]) {
        var player1: [Int] = []
        var player2: [Int] = []
        let blocks = data.raw.components(separatedBy: "\n\n")
        guard blocks.count == 2 else { fatalError("Blocks count (\(blocks.count)) should be 2.") }
        var playerNum = 0
        while playerNum <= 1 {
            for card in blocks[playerNum].components(separatedBy: "\n") {
                if card.last != ":" {
                    switch playerNum {
                    case 0:
                        player1.append(Int(card)!)
                    case 1:
                        player2.append(Int(card)!)
                    default:
                        ()
                    }
                }
            }
            playerNum += 1
        }
        return (player1,player2)
    }
    
    enum Winner {
        case player1
        case player2
        case neither
    }
    
    func resolveHand(player1: Int, player2: Int) -> (Winner,[Int]) {
        if player1 == player2 { return (Winner.neither, [player1, player2]) }
        else if player1 > player2 { return (Winner.player1, [player1, player2]) }
        else { return (Winner.player2, [player2, player1]) }
    }
    
    func determineWinner(player1: [Int], player2: [Int]) -> Winner {
        if player1.count == 0 { return .player2 }
        else if player2.count == 0 { return .player1 }
        else { return .neither }
    }
    
    func countScore(hand: [Int]) -> Int {
        let a: [Int] = hand.reversed()
        var score = 0
        for i in 1...a.count {
            score += i * a[i - 1]
        }
        return score
    }
    
    func combat(players: ([Int],[Int]), recursive: Bool = false) -> (winner: Winner, score: Int) {
        var players = players
        var winner: Winner = .neither
        var history: (player1: [[Int]], player2: [[Int]]) = ([],[])
        
        
        func wasItTheSameCat(hands: (player1: [Int], player2: [Int])) -> Bool {
            var same = false
            for hist in history.player1 {
                if hands.player1 == hist { same = true }
            }
            for hist in history.player2 {
                if hands.player2 == hist { same = true }
            }
            return same
        }
        var cnt = 0
        repeat  {
            cnt += 1
            //print(cnt)
            if recursive && wasItTheSameCat(hands: (players.0, players.1)) {
                // I know kung-fu
                return (Winner.player1, countScore(hand: players.0))
            }
            history.player1.append(players.0)
            history.player2.append(players.1)
            let draw = (players.0.removeFirst(),players.1.removeFirst())
            if recursive && players.0.count >= draw.0 && players.1.count >= draw.1 {
                // load the jump program
                let p1 = Array(players.0[0..<draw.0])
                let p2 = Array(players.1[0..<draw.1])
                let sbPlayers = (p1,p2)
                let result = combat(players: sbPlayers, recursive: recursive).winner
                switch result {
                case .player1:
                    players.0.append(draw.0)
                    players.0.append(draw.1)
                case .player2:
                    players.1.append(draw.1)
                    players.1.append(draw.0)
                case.neither:
                    players.0.append(draw.0)
                    players.1.append(draw.1)
                }
                winner = determineWinner(player1: players.0, player2: players.1)
            } else {
                // I'm not the One.
                let hand = resolveHand(player1: draw.0, player2: draw.1)
                switch hand.0 {
                case .player1:
                    players.0.append(contentsOf: hand.1)
                case .player2:
                    players.1.append(contentsOf: hand.1)
                case.neither:
                    players.0.append(hand.1[0])
                    players.1.append(hand.1[1])
                }
                winner = determineWinner(player1: players.0, player2: players.1)
            }
            
        } while winner == .neither
        
        var winningHand: [Int] = []
        switch winner {
        case .player1:
            winningHand = players.0
        case .player2:
            winningHand = players.1
        default:
            fatalError("No winner, but there should be.")
        }
        
        return (winner, countScore(hand: winningHand))
    }
    
    func part1() -> Any { // 32783 <- for testing changes
        let players = deal()
        let result = combat(players: players)
        return result.score
    }

    func part2() -> Any {
        let players = deal()
        let result = combat(players: players, recursive: true)
        return result.score
    }
}


fileprivate let testInput = Data(raw: """
Player 1:
9
2
6
3
1

Player 2:
5
8
4
7
10
""")  // 306/291



