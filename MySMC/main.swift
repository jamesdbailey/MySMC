//
//  main.swift
//  MySMC

import Foundation

enum FlagsType: String {
    case temperature = "T"
    case voltage = "V"
    case power = "P"
    case all
    
    init(value: String) {
        switch value {
        case "-t": self = .temperature
        case "-v": self = .voltage
        case "-p": self = .power
        default: self = .all
        }
    }
}

func readSensors(smc: SMC, prefix: String) -> Dictionary<String, Double> {
    var dict = [String: Double]()
    var keys = smc.getAllKeys()
    keys = keys.filter{ $0.hasPrefix(prefix)}
    keys.forEach {
        (key: String) in
        let value = smc.getValue(key)
        dict[key] = value
    }
    
    return dict
}

func main() {
    let smc = SMC()
    let args = CommandLine.arguments
    if (args.count > 1) {
        let arg = args[1]
        let sensors = readSensors(smc: smc, prefix: FlagsType(value: arg).rawValue)
        
        print("[INFO]: found \(sensors.count) keys\n")
        
        sensors.forEach {
            (key: String, value: Double) in
            print("[\(key)]    ", value)
        }
    }
}

main()
