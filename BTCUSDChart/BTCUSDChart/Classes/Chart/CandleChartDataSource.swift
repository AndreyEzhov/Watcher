//
//  CandleChartDataSource.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import UIKit

class CandleChartDataSource {
    
    // MARK: - Properties
    
    let points: [CandleChartDataPoint]
    
    private(set) var minY: Double!
    
    private(set) var maxY: Double!
    
    private(set) var precision: Int = 2
    
    var decreasingColor = UIColor.red
    
    var increasingColor = UIColor.green
    
    var shadowColor = UIColor.black
    
    // MARK: - Construction
    
    init(with points: [CandleChartDataPoint]) {
        self.points = points
        calculateMinMax()
    }
    
    // MARK: - Private Functions
    
    private func calculateMinMax() {
        points.forEach({
            minY = min(minY ?? $0.low, $0.low)
            maxY = max(maxY ?? $0.high, $0.high)
        })
    }
    
}
