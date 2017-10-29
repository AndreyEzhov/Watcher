//
//  CandleModel.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import Foundation

class CandleModel {
    
    // MARK: - Properties
    
    let x: Int
    
    private(set) var shadowH: Double
    
    private(set) var shadowL: Double
    
    private(set) var open: Double
    
    private(set) var close: Double
    
    // MARK: - Construction
    
    init?(x: Int, tick: TickModel) {
        self.x = x
        guard let b = tick.b else {
            return nil
        }
        shadowH = b
        shadowL = b
        open = b
        close = b
    }
    
    // MARK: - Functions
    
    func update(tick: TickModel) {
        guard let b = tick.b else {
            return
        }
        close = b
        shadowH = max(shadowH, b)
        shadowL = min(shadowL, b)
    }
}
