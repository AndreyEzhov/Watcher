//
//  Router.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import UIKit

class Router {
    
    // MARK: - Properties
    
    static let shared = Router()
    
    var rootController: UINavigationController? {
        return UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
    }
    
    // MARK: - Construction
    
    private init () {}
    
    // MARK: - Functions
    
    func loadInitial() -> UIWindow {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        window.rootViewController = Assembly.shared.root()
        
        return window
    }
}
