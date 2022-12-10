
import Foundation

struct p2022_10: Puzzle {
    //var data = testInput.parseToStringArray()
    //var data = testInput2.parseToStringArray()
    var data = input_2022_10.parseToStringArray()
    var runPart = 2
    
    struct Command {
        
        enum Commands { case noop, addx }
        
        let command: Commands
        let timeCost: Int
        var value: Int
        
        init(command: Commands, value: Int?) {
            self.command = command
            switch command {
            case .noop:
                self.timeCost = 1
                self.value = 0
            case .addx:
                self.timeCost = 2
                self.value = value!
            }
        }
    }
    
    struct CPU{
        private var cycle = 0
        private var registers: [Character:Int] = ["X":1]
        private var queue: [Command] = []
        var isIdle: Bool { get { queue.isEmpty && self.currentProcess.command == nil } }
        var time: Int { get { cycle } }
        var count: Int { get { queue.count } }
        private var currentProcess: (command: Command?, started: Int?) = (command: nil, started: nil)
        var crt: CRT? = nil
        
        private func currentProcessFinished() -> Bool {
            if currentProcess.command != nil {
                let timeSinceStarted = self.cycle - self.currentProcess.started!
                let remainingTime = self.currentProcess.command!.timeCost - timeSinceStarted
                if remainingTime <= 0 { return true } else { return false }
            }
            return true
        }
        
        func getRegisterValue(register: Character) -> Int {
            return self.registers[register] ?? -99
        }
        
        mutating func tick() {
            if !self.queue.isEmpty {
                if self.currentProcess.command == nil {
                    self.currentProcess.command = self.queue[0]
                    self.currentProcess.started = self.cycle
                    self.queue.removeFirst()
                }
            }
            self.cycle += 1
        }
        
        mutating func finalize() {
            
            if self.currentProcess.command != nil {
                if self.currentProcessFinished() {
                    self.registers["X"]! += self.currentProcess.command!.value
                    self.currentProcess.command = nil
                }
            }
        }
        
        mutating func add(command: Command) {
            self.queue.append(command)
        }
        
        mutating func run(interestingSignals: [Int] = []) -> Int {
            var interestingSignalStrengths: [Int] = []
            while !self.isIdle {
                self.tick()
                if interestingSignals.contains(self.time) {
                    let mtr = self.cycle * self.registers["X"]!
                    interestingSignalStrengths.append(mtr)
                }
                if self.crt != nil {
                    let pos = self.registers["X"]!
                    let sprite = (pos-1)...(pos+1)
                    self.crt?.advance(cycle: self.cycle, sprite: sprite)
                }
                self.finalize()
                
            }
            return interestingSignalStrengths.sum()
        }
    }
    
    struct CRT {
        private var pixelBuffer: [[Character]] = Array(
            repeating: Array(repeating: ".", count: 40),
            count: 6
        )
        
        mutating func advance(cycle: Int, sprite: ClosedRange<Int>) {
            let row = Int(floor(Float(cycle-1) / 40.0))
            let col = cycle - (row * 40) - 1
            if sprite.contains(col) {
                pixelBuffer[row][col] = "#"
            }
        }
        
        func getImage() -> String {
            var image = ""
            for row in self.pixelBuffer {
                image += String(row) + "\n"
            }
            return image
        }
    }
    
    func part1() -> Any {
        var cpu = CPU()
        data.forEach { instruction in
            let comps = instruction.split(separator: " ")
            let command: Command
            if comps[0] == "noop" {
                command = Command(command: .noop, value: nil)
                
            } else {
                command = Command(command: .addx, value: Int(comps[1])!)
            }
            cpu.add(command: command)
        }
        
        return cpu.run(interestingSignals: [20,60,100,140,180,220])
    }
    
    func part2() -> Any {
        var cpu = CPU()
        cpu.crt = CRT()
        data.forEach { instruction in
            let comps = instruction.split(separator: " ")
            let command: Command
            if comps[0] == "noop" {
                command = Command(command: .noop, value: nil)
                
            } else {
                command = Command(command: .addx, value: Int(comps[1])!)
            }
            cpu.add(command: command)
        }
        let _ = cpu.run()
        return cpu.crt!.getImage()
    }
}


/*
 Pt 1 test target: -
 Pt 2 test 2 target: 13140
 pt 2 test target:
 ##..##..##..##..##..##..##..##..##..##..
 ###...###...###...###...###...###...###.
 ####....####....####....####....####....
 #####.....#####.....#####.....#####.....
 ######......######......######......####
 #######.......#######.......#######.....
 */

fileprivate let testInput = Data(raw: """
noop
addx 3
addx -5
""")

fileprivate let testInput2 = Data(raw: """
addx 15
addx -11
addx 6
addx -3
addx 5
addx -1
addx -8
addx 13
addx 4
noop
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx 5
addx -1
addx -35
addx 1
addx 24
addx -19
addx 1
addx 16
addx -11
noop
noop
addx 21
addx -15
noop
noop
addx -3
addx 9
addx 1
addx -3
addx 8
addx 1
addx 5
noop
noop
noop
noop
noop
addx -36
noop
addx 1
addx 7
noop
noop
noop
addx 2
addx 6
noop
noop
noop
noop
noop
addx 1
noop
noop
addx 7
addx 1
noop
addx -13
addx 13
addx 7
noop
addx 1
addx -33
noop
noop
noop
addx 2
noop
noop
noop
addx 8
noop
addx -1
addx 2
addx 1
noop
addx 17
addx -9
addx 1
addx 1
addx -3
addx 11
noop
noop
addx 1
noop
addx 1
noop
noop
addx -13
addx -19
addx 1
addx 3
addx 26
addx -30
addx 12
addx -1
addx 3
addx 1
noop
noop
noop
addx -9
addx 18
addx 1
addx 2
noop
noop
addx 9
noop
noop
noop
addx -1
addx 2
addx -37
addx 1
addx 3
noop
addx 15
addx -21
addx 22
addx -6
addx 1
noop
addx 2
addx 1
noop
addx -10
noop
noop
addx 20
addx 1
addx 2
addx 2
addx -6
addx -11
noop
noop
noop
""")


