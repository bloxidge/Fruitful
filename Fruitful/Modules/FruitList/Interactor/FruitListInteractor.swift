//
//  FruitListInteractor.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import Foundation
import PromiseKit

protocol FruitListInteractor: AnyObject {
    var allFruit: [Fruit]? { get }
    
    func fetchAllFruit() -> Promise<[Fruit]>
}

class FruitListInteractorImpl: FruitListInteractor {
    
    var allFruit: [Fruit]?
    
    func fetchAllFruit() -> Promise<[Fruit]> {
        return Promise<[Fruit]> { resolver in
            if let fruit = allFruit {
                resolver.fulfill(fruit)
            } else {
                // TODO: Replace with API call
                waitForStubbedFruit()
                    .done {
                        self.allFruit = $0
                        resolver.fulfill($0)
                    }
            }
        }
    }
    
    // TODO: Remove once API service in place
    private func waitForStubbedFruit() -> Guarantee<[Fruit]> {
        after(seconds: 1.0)
            .map { fruitStub }
    }
}

fileprivate let fruitStub = [
    Fruit(type: "apple", price: 149, weight: 120),
    Fruit(type: "banana", price: 129, weight: 80),
    Fruit(type: "blueberry", price: 19, weight: 18),
    Fruit(type: "orange", price: 199, weight: 150),
    Fruit(type: "pear", price: 99, weight: 100),
    Fruit(type: "strawberry", price: 99, weight: 20),
    Fruit(type: "kumquat", price: 49, weight: 80),
    Fruit(type: "pitaya", price: 599, weight: 100),
    Fruit(type: "kiwi", price: 89, weight: 200),
]
