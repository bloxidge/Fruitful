//
//  FruitListPresenter.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import Foundation
import PromiseKit

protocol FruitListPresenter: AnyObject {
    var view: FruitListView! { get set }
    var interactor: FruitListInteractor! { get set }
    var router: FruitListRouter! { get set }
    
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
    
    @discardableResult
    func reload(showLoading: Bool) -> Promise<Void> {
        if showLoading {
            view.showLoading()
        }
        
        let promise = interactor.fetchAllFruit()
        promise.done { [weak self] fruit in
                if fruit.isEmpty {
                    self?.view.showEmptyList()
                } else {
                    self?.view.showPopulatedList()
                }
            }.catch { [weak self] error in
                AnalyticsServiceImpl.shared.track(event: .error(error.localizedDescription))
                self?.view.showError()
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
        router.presentDetail(for: fruit)
    }
}
