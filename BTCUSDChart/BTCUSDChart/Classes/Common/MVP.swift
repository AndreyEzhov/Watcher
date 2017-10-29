//
//  MVP.swift
//  BTCUSDChart
//
//  Created by Андрей Ежов on 28.10.17.
//  Copyright © 2017 Андрей Ежов. All rights reserved.
//

import UIKit


protocol View: class { }

protocol Presenter: AnyPresenter {
    
    associatedtype T
    
    func contentView () -> T
}

extension Presenter {
    func contentView () -> T {
        return view as! T
    }
}

protocol AnyPresenter: class {
    weak var view: View? { get set }
}

class BaseViewController<T>: UIViewController, View {
    
    // MARK: - Properties
    
    var presenter: T?
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Functions
    
    class func controller (presenter: T?) -> Self {
        let vc = self.controller()
        
        vc.presenter = presenter
        (presenter as! AnyPresenter).view = vc
        
        return vc
    }
}
