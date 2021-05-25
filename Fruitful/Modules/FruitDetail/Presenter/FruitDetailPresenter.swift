//
//  FruitDetailPresenter.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import Foundation

protocol FruitDetailPresenter: AutoMockable {
    func attachToView()
    func didPressClose()
}

class FruitDetailPresenterImpl: FruitDetailPresenter {
    
    var view: FruitDetailView!
    var router: FruitDetailRouter!
    
    let fruit: Fruit
    
    init(fruit: Fruit) {
        self.fruit = fruit
    }
    
    func attachToView() {
        view.updateView(state: .initial(fruit))
    }
    
    func didPressClose() {
        AnalyticsServiceImpl.shared.track(screenEvent: .requested(.fruitList))
        router.dismissDetail()
    }
}
