//
//  Assembly.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import UIKit

class Assembly {
    
    // MARK: - Properties
    
    static var shared = Assembly()
    
    // MARK: - Construction
    
    private init () {}
    
    // MARK: - Functions
    
    func root() -> UINavigationController {
        return UINavigationController(rootViewController: chart())
    }
    
    func chart() -> UIViewController {
        return ChartViewController.controller(presenter: ChartPresenter())
    }
}
