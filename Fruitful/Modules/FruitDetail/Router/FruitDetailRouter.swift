//
//  FruitDetailRouter.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import UIKit

protocol FruitDetailRouter: AnyObject {
    func dismissDetail()
}

class FruitDetailRouterImpl: FruitDetailRouter {
    
    weak var viewController: UIViewController?
    
    func dismissDetail() {
        viewController?.dismiss(animated: true, completion: nil)
    }
}
