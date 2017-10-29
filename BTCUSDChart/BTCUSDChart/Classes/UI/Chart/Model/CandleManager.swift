//
//  CandleManager.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import Foundation

class CandleManager {
    
    // MARK: - Properties
    
    private(set) var candles = [CandleModel]()
    
    private(set) var currentValue: String!
    
    private(set) var firstDate: Date!
    
    private(set) var lastDate: Date!
    
    // MARK: - Private Functions
    
    private func append(tick: TickModel, atDate: Date) -> Bool {
        let x = firstDate == nil ? 0 : firstDate.minuts(from: atDate)
        guard let candleModel = CandleModel(x: x, tick: tick) else {
            return false
        }
        candles.append(candleModel)
        lastDate = atDate
        return true
    }
    
    private func removeOldCandels() {
        if candles.count > 60 {
            candles.remove(at: 0)
        }
    }
    
    // MARK: - Functions
    
    func add(tick: TickModel) {
        let currendDate = Date()
        
        if firstDate == nil {
            if append(tick: tick, atDate: currendDate) {
                firstDate = currendDate
            }
            return
        }
        
        if lastDate.minuts(from: currendDate) == 0 {
            candles.last?.update(tick: tick)
            lastDate = currendDate
            return
        }
        
        _ = append(tick: tick, atDate: currendDate)
        removeOldCandels()
    }
    
}
