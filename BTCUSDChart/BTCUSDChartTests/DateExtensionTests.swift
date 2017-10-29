//
//  DateExtensionTests.swift
//  BTCUSDChartTests
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import XCTest

class DateExtensionTests: XCTestCase {
    
    // MARK: - Tests
    
    func testDateExtention() {
        var dateFirst = Date(timeIntervalSince1970: 0)
        var dateSecond = Date(timeIntervalSince1970: 1)
        
        XCTAssertEqual(dateFirst.minuts(from: dateSecond), 0)
        
        dateFirst = Date(timeIntervalSince1970: 0)
        dateSecond = Date(timeIntervalSince1970: 59)
        
        XCTAssertEqual(dateFirst.minuts(from: dateSecond), 0)
        
        dateFirst = Date(timeIntervalSince1970: 59.999)
        dateSecond = Date(timeIntervalSince1970: 60)
        
        XCTAssertEqual(dateFirst.minuts(from: dateSecond), 1)
        
        dateFirst = Date(timeIntervalSince1970: 59)
        dateSecond = Date(timeIntervalSince1970: 61)
        
        XCTAssertEqual(dateFirst.minuts(from: dateSecond), 1)
        
        dateFirst = Date(timeIntervalSince1970: 59)
        dateSecond = Date(timeIntervalSince1970: 121)
        
        XCTAssertEqual(dateFirst.minuts(from: dateSecond), 2)
    }
    
}
