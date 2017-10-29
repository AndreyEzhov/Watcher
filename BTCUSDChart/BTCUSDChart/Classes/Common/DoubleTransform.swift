//
//  DoubleTransform.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import Foundation
import ObjectMapper

open class DoubleTransform: TransformType {

    public typealias Object = Double
    public typealias JSON = String
    
    public init() {}
    
    open func transformFromJSON(_ value: Any?) -> Double? {
        guard let value = value as? String else {
            return nil
        }
        return Double(value)
    }
    
    open func transformToJSON(_ value: Double?) -> String? {
        guard let value = value else {
            return nil
        }
        return String(value)
    }
}
