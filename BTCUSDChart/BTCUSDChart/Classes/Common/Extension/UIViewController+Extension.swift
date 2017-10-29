//
//  UIViewController+Extension.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import UIKit

extension UIViewController {
    public class func controller() -> Self {
        let storyboardName = NSStringFromClass(self).components(separatedBy: ".").last ?? ""
        
        let controller = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()
        return typeCast(controller, type: self)
    }
}
