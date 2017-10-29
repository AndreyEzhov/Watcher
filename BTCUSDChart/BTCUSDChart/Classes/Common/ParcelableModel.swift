//
//  ParcelableModel.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import Foundation
import ObjectMapper

class ParcelableModel: Mappable {
    
    // MARK: - Construction
    
    required init?(map: Map) {
        self.mapping(map: map)
    }
    
    // MARK: - Functions
    
    func mapping(map: Map) { }
}
