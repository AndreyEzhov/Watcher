//
//  Double+Extension.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import Foundation

extension Double {
    static func random() -> Double {
        return Double(Int(arc4random()) * (arc4random()%2 == 0 ? 1 : -1)) * 0.01
    }
    
    func toString(precision: Int = 4) -> String {
        return String(format: "%.\(precision)f", self)
    }
}
