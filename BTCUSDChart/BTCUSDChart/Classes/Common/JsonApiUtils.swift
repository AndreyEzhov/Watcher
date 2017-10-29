//
//  JsonApiUtils.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import Foundation
import ObjectMapper

class JsonApiUtils {
    
    // MARK: - Functions
    
    class func object<T: ParcelableModel>(of type: T.Type, string: String?, error: NSErrorPointer? = nil) -> T? {
        guard let string = string,
            let data = string.data(using: .utf8),
            let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any],
            let jsonObject = jsonDictionary
            else {
                return nil
        }
        
        return type.init(map: Map(mappingType: .fromJSON, JSON: jsonObject))
    }
}
