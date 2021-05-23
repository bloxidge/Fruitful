//
//  FruitListModule.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import UIKit

class FruitListModule {
    
    static func build() -> UIViewController {
        let view = FruitListViewController.instantiateFromStoryboard(name: "FruitList")
        let presenter = FruitListPresenterImpl()
        let interactor = FruitListInteractorImpl(api: ApiServiceImpl(requestBuilder: URLRequestBuilderImpl()))
        let router = FruitListRouterImpl()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        router.viewController = view
        
        return view
    }
}
