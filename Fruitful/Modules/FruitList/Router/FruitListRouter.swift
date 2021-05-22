//
//  FruitListRouter.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import UIKit

protocol Router: AnyObject {
    static func createModule() -> UIViewController
}

class FruitListRouter: Router {
    
    static func createModule() -> UIViewController {
        let view = FruitListViewController.instantiateFromStoryboard(name: "FruitList")
        let presenter = FruitListPresenterImpl()
        let interactor = FruitListInteractorImpl()
        let router = FruitListRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        return view
    }
}
