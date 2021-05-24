//
//  FruitDetailPresenter.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import Foundation

protocol FruitDetailPresenter: AnyObject {
    var view: FruitDetailView? { get }
    var interactor: FruitDetailInteractor? { get }
    var router: FruitDetailRouter? { get }
    
    func loadView()
    func didPressClose()
}

class FruitDetailPresenterImpl: FruitDetailPresenter {
    
    var view: FruitDetailView?
    var interactor: FruitDetailInteractor?
    var router: FruitDetailRouter?
    
    let fruit: Fruit
    
    init(fruit: Fruit) {
        self.fruit = fruit
    }
    
    func loadView() {
        view?.showDetails(for: fruit)
    }
    
    func didPressClose() {
        AnalyticsServiceImpl.shared.track(screenEvent: .requested(.fruitList))
        router?.dismissDetail()
    }
}
