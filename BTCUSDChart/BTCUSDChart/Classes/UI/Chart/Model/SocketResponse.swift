//
//  SocketResponse.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import Foundation
import ObjectMapper

class SocketResponse: ParcelableModel {
    
    // MARK: - Properties
    
    private(set) var ticks = [String: TickModel]()
    
    // MARK: - Construction
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        var ticksArray: [TickModel]?
        ticksArray <- map[Consts.JSON.ticks]
        
        ticksArray?.forEach({
            guard let key = $0.s else {
                return
            }
            ticks[key] = $0
        })
    }
}
