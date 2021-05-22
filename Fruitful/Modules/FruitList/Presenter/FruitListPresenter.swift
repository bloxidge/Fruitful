//
//  FruitListPresenter.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import Foundation

protocol FruitListPresenter: AnyObject {
    var view: FruitListView? { get set }
    var interactor: FruitListInteractor? { get set }
    var router: FruitListRouter? { get set }
    
    func reload()
    func getFruitCount() -> Int?
    func getFruit(at index: Int) -> Fruit?
    func didSelect(fruit: Fruit)
}

class FruitListPresenterImpl: FruitListPresenter {
    
    var view: FruitListView?
    var interactor: FruitListInteractor?
    var router: FruitListRouter?
    
    func reload() {
        view?.showLoading()
        interactor?.fetchAllFruit()
            .done { [weak self] fruit in
                self?.view?.showFruitList()
            }
            .catch { [weak self] _ in
                self?.view?.showError()
            }
    }
    
    func getFruitCount() -> Int? {
        return interactor?.allFruit?.count
    }
    
    func getFruit(at index: Int) -> Fruit? {
        return interactor?.allFruit?[index]
    }
    
    func didSelect(fruit: Fruit) {
        router?.presentDetail(for: fruit)
    }
}
