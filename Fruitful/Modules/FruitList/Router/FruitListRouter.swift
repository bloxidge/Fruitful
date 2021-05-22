//
//  FruitListRouter.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import UIKit

protocol FruitListRouter: AnyObject {
    func presentDetail(for fruit: Fruit)
}

class FruitListRouterImpl: FruitListRouter {
    
    weak var viewController: UIViewController?
    
    func presentDetail(for fruit: Fruit) {
        let detailViewController = FruitDetailModule.build(fruit: fruit)
        detailViewController.modalPresentationStyle = .fullScreen
        viewController?.present(detailViewController, animated: true, completion: nil)
    }
}
