//
//  GrandCentralDispatch.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import Foundation

public func onMain(_ block:@escaping () -> Void) {
    if Thread.isMainThread {
        block()
        return
    }
    DispatchQueue.main.async {
        block()
    }
}

