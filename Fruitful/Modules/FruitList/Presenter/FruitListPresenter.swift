//
//  FruitListPresenter.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import Foundation
import PromiseKit

protocol FruitListPresenter: AutoMockable {
    func attachToView()
    @discardableResult
    func reload(showLoading: Bool) -> Promise<Void>
    func getFruitCount() -> Int?
    func getFruit(at index: Int) -> Fruit?
    func didSelect(fruit: Fruit)
}

class FruitListPresenterImpl: FruitListPresenter {
    
    var view: FruitListView!
    var interactor: FruitListInteractor!
    var router: FruitListRouter!
    
    func attachToView() {
        view.updateView(state: .initial)
    }
    
    @discardableResult
    func reload(showLoading: Bool) -> Promise<Void> {
        if showLoading {
            view.updateView(state: .loading)
        }
        
        let promise = interactor.fetchAllFruit()
        promise.done { [weak self] fruit in
            if fruit.isEmpty {
                self?.view.updateView(state: .doneEmpty)
            } else {
                self?.view.updateView(state: .doneResults)
            }
        }.catch { [weak self] error in
            AnalyticsServiceImpl.shared.track(event: .error(error.localizedDescription))
            self?.view.updateView(state: .error)
        }
        return promise.asVoid()
    }
    
    func getFruitCount() -> Int? {
        return interactor.allFruit?.count
    }
    
    func getFruit(at index: Int) -> Fruit? {
        return interactor.allFruit?[index]
    }
    
    func didSelect(fruit: Fruit) {
        AnalyticsServiceImpl.shared.track(screenEvent: .requested(.fruitDetail))
        router.presentDetail(for: fruit)
    }
}
