//
//  TickModelTest.swift
//  BTCUSDChartTests
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import XCTest

class TickModelTest: XCTestCase {
    
    // MARK: - Tests
    
    func testSocketResponseInitialisation() {
        let s = "BTCUSD"
        let b = "5713.96"
        let bf = 0
        let a = "5719.84"
        let af = 2
        let spr = "58.8"
        
        let string = "{\"ticks\":[{\"s\":\"\(s)\",\"b\":\"\(b)\",\"bf\":\(bf),\"a\":\"\(a)\",\"af\":\(af),\"spr\":\"\(spr)\"}]}"
        
        let socketResponseResult = JsonApiUtils.object(of: SocketResponse.self, string: string)
        XCTAssertNotNil(socketResponseResult)
        
        guard let socketResponse = socketResponseResult else {
            return
        }
        
        let tickModelResult = socketResponse.ticks[Consts.Positions.BTCUSD]
        XCTAssertNotNil(tickModelResult)
        
        guard let tickModel = tickModelResult else {
            return
        }
        
        XCTAssertEqual(s, tickModel.s)
        XCTAssertEqual(Double(b), tickModel.b)
        XCTAssertEqual(bf, tickModel.bf)
        XCTAssertEqual(a, tickModel.a)
        XCTAssertEqual(af, tickModel.af)
        XCTAssertEqual(spr, tickModel.spr)
    }
    
}
