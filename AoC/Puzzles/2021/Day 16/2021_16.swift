import Foundation

struct p2021_16: Puzzle {
    //var data = Data(raw:"8A004A801A8002F478") // part 1 - 16
    //var data = Data(raw:"620080001611562C8802118E34") // part 1 - 12
    //var data = Data(raw:"C0015000016115A2E0802F182340") // part 1 - 23
    //var data = Data(raw:"A0016C880162017C3686B18A3D4780") // part 1 - 31
    //var data = Data(raw:"C200B40A82") // part 2 - 3
    //var data = Data(raw:"04005AC33890") // part 2 - 54
    //var data = Data(raw:"880086C3E88112") // part 2 - 7
    //var data = Data(raw:"CE00C43D881120") // part 2 - 9
    //var data = Data(raw:"D8005AC2A8F0") // part 2 - 1
    //var data = Data(raw:"F600BC2D8F") // part 2 - 0
    //var data = Data(raw:"9C005AC2F8F0") // part 2 - 0
    //var data = Data(raw:"9C0141080250320F1802104A08") // part 2 - 1
    var data = input_2021_16
    var runPart = 2
    


    struct Packet {
        var packetVersion:Int
        var typeId:Int
        var transmissionValue:Int
        var subpackets:[Packet] = []
        var versionNumberSum: Int {
            packetVersion + subpackets.map { $0.versionNumberSum }.reduce(0) { $0 + $1 }
        }
    }
 
    func createPacket(bits: inout [Bool]) -> Packet {
        let packetVersion = convertToInt(popFirst(from: &bits, num: 3))
        let typeId = convertToInt(popFirst(from: &bits, num: 3))
        var subpackets: [Packet] = []
        
        if typeId == 4 {
            var literalValue:[Bool] = []
            while bits.first != false {
                literalValue.append(contentsOf: popFirst(from: &bits, num: 5).dropFirst())
            }
            literalValue.append(contentsOf: popFirst(from: &bits, num: 5).dropFirst())
            return Packet(packetVersion: packetVersion, typeId: typeId, transmissionValue: convertToInt(literalValue))
        }
        
        let lengthTypeId = bits.removeFirst()
        if lengthTypeId {
            let numSubpackets = convertToInt(popFirst(from: &bits, num: 11))
            for _ in 0 ..< numSubpackets {
                subpackets.append(createPacket(bits: &bits))
            }
        } else {
            let subpacketLength = convertToInt(popFirst(from: &bits, num: 15))
            let targetCount = bits.count - subpacketLength
            while bits.count != targetCount {
                subpackets.append(createPacket(bits: &bits))
            }
        }
        
        let values = subpackets.map { $0.transmissionValue }
        var opTypeCode: Int {
            switch typeId {
            case 0: return values.reduce(0, +)
            case 1: return values.reduce(1, *)
            case 2: return values.min()!
            case 3: return values.max()!
            case 5: return values[0] > values[1] ? 1 : 0
            case 6: return values[0] < values[1] ? 1 : 0
            case 7: return values[0] == values[1] ? 1 : 0
            default: fatalError("Unexpected input")
            }
        }
        
        return Packet(packetVersion: packetVersion, typeId: typeId, transmissionValue: opTypeCode, subpackets: subpackets)
    }
    
    func convertToInt(_ bitsArray: [Bool]) -> Int {
        return Int(bitsArray.map { $0 ? "1" : "0" }.joined(),radix:2)!
    }
    
    func popFirst<T>(from arr: inout [T], num: Int = 1) -> [T] {
        let retArr = Array(arr.prefix(num))
        arr.removeFirst(num)
        return retArr
    }

    func part1() -> Any {
        let intVals:[Int] = data.parseToSimpleCharArray().map { Int(String($0),radix: 16)! }
        var bits = intVals.flatMap { $0.bits.suffix(4) }
        let packet = createPacket(bits: &bits)
        return packet.versionNumberSum
    }

    func part2() -> Any {
        let intVals:[Int] = data.parseToSimpleCharArray().map { Int(String($0),radix: 16)! }
        var bits = intVals.flatMap { $0.bits.suffix(4) }
        let packet = createPacket(bits: &bits)
        return packet.transmissionValue
        }
}





