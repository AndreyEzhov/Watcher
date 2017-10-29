//
//  TypeCast.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import Foundation

public func typeCast<T>(_ object: AnyObject?, type: T.Type) -> T {
    return (object as! T)
}
