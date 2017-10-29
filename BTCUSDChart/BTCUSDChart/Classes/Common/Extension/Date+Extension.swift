//
//  Date+Extension.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import Foundation

extension Date {
    func minuts(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: roundToMinuts(), to: date.roundToMinuts()).minute ?? 0
    }
    
    func roundToMinuts() -> Date {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: self)
        return Calendar.current.date(from: components) ?? self
    }
}
