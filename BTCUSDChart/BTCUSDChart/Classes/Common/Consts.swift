//
//  Consts.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import UIKit

struct Consts {
    
    struct JSON {
        static let ticks = "ticks"
        
        static let s = "s"
        
        static let b = "b"
        
        static let bf = "bf"
        
        static let a = "a"
        
        static let af = "af"
        
        static let spr = "spr"
    }
    
    struct Positions {
        static let BTCUSD = "BTCUSD"
    }
    
    enum Socket {
        static let url = "wss://quotes.exness.com:18400/"
        
        case subscribe(String)
        
        case unsubscribe(String)
        
        var asComand: String {
            switch self {
            case .subscribe(let unit):
                return "SUBSCRIBE: \(unit)"
            case .unsubscribe(let unit):
                return "UNSUBSCRIBE: \(unit)"
            }
        }
    }
    
}
