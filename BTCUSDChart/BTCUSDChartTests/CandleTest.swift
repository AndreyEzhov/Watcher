//
//  CandleTest.swift
//  BTCUSDChartTests
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import XCTest

class CandleTest: XCTestCase {
    
    // MARK: - Tests
    
    func testCandleModel() {
        
        var open: Double!
        var close: Double!
        var shadowL: Double!
        var shadowH: Double!
        
        var candleModel: CandleModel!
        
        let start = 0
        let end = 60
        
        for i in start...end {
            let bDouble = Double.random()
            guard let ticksModel = generateTickWith(bDouble: bDouble),
                let tickModel = ticksModel.ticks[Consts.Positions.BTCUSD] else {
                    continue
            }
            
            if i == start {
                open = bDouble
                close = bDouble
                shadowL = bDouble
                shadowH = bDouble
            } else if i == end {
                close = bDouble
            }
            
            shadowL = min(shadowL, bDouble)
            shadowH = max(shadowH, bDouble)
            
            if candleModel == nil {
                candleModel = CandleModel(x: 0, tick: tickModel)
            } else {
                candleModel.update(tick: tickModel)
            }
        }
        
        XCTAssertNotNil(candleModel)
        
        XCTAssertLessThan(abs(candleModel.close - close), 10 * Double.ulpOfOne)
        XCTAssertLessThan(abs(candleModel.open - open), 10 * Double.ulpOfOne)
        XCTAssertLessThan(abs(candleModel.shadowH - shadowH), 10 * Double.ulpOfOne)
        XCTAssertLessThan(abs(candleModel.shadowL - shadowL), 10 * Double.ulpOfOne)
        
    }
    
    func testCandleManager() {
        let candleManager = CandleManager()
        let expectation = XCTestExpectation()
        
        let time = 60
        
        let block = {
            guard let ticks = self.generateTickWith(bDouble: 0.0),
                let tick = ticks.ticks[Consts.Positions.BTCUSD] else {
                    XCTAssert(false)
                    return
            }
            candleManager.add(tick: tick)
        }
        
        block()
        
        Timer.scheduledTimer(withTimeInterval: TimeInterval(time),
                             repeats: true) { _ in
                                block()
                                XCTAssertEqual(candleManager.firstDate.minuts(from: candleManager.lastDate), 1)
                                XCTAssertEqual(candleManager.candles.count, 2)
                                expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: TimeInterval(time))
    }
    
    // MARK: - Private Functions
    
    private func generateTickWith(bDouble: Double) -> SocketResponse? {
        let s = "BTCUSD"
        let b = "\(bDouble)"
        let bf = 0
        let a = "5719.84"
        let af = 2
        let spr = "58.8"
        
        let string = "{\"ticks\":[{\"s\":\"\(s)\",\"b\":\"\(b)\",\"bf\":\(bf),\"a\":\"\(a)\",\"af\":\(af),\"spr\":\"\(spr)\"}]}"
        return JsonApiUtils.object(of: SocketResponse.self, string: string)
    }
    
}
