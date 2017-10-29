//
//  CandleChartDataEntry.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import Foundation

class CandleChartDataPoint {
    
    // MARK: - Properties
    
    private(set) var x: Int
    
    private(set) var high: Double
    
    private(set) var low: Double
    
    private(set) var close: Double
    
    private(set) var open: Double
    
    // MARK: - Construction
    
    init(x: Int, shadowH: Double, shadowL: Double, open: Double, close: Double) {
        self.x = x
        self.high = shadowH
        self.low = shadowL
        self.open = open
        self.close = close
    }
    
}
