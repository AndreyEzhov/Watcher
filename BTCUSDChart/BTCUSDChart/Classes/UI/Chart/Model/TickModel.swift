//
//  TickModel.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import Foundation
import ObjectMapper

class TickModel: ParcelableModel {
    
    // MARK: - Properties
    
    private(set) var s: String?
    
    private(set) var b: Double?
    
    private(set) var bf: Int?
    
    private(set) var a: String?
    
    private(set) var af: Int?
    
    private(set) var spr: String?
    
    // MARK: - Construction
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        s <- map[Consts.JSON.s]
        b <- (map[Consts.JSON.b], DoubleTransform())
        bf <- map[Consts.JSON.bf]
        a <- map[Consts.JSON.a]
        af <- map[Consts.JSON.af]
        spr <- map[Consts.JSON.spr]
    }
}
