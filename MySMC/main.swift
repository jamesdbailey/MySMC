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

func main() {
    let smc = SMC()
    let args = CommandLine.arguments.dropFirst()
    
    var keys = smc.getAllKeys()
    args.forEach { (arg: String) in
        let flag = FlagsType(value: arg)
        if flag != .all {
            keys = keys.filter{ $0.hasPrefix(flag.rawValue)}
        }
    }
    
    print("[INFO]: found \(keys.count) keys\n")
    
    keys.forEach { (key: String) in
        let value = smc.getValue(key)
        print("[\(key)]    ", value ?? 0)
    }
}

main()
