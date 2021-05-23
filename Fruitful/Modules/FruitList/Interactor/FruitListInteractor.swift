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
    
    let api: ApiService
    
    init(api: ApiService) {
        self.api = api
    }
    
    func fetchAllFruit() -> Promise<[Fruit]> {
        api.send(request: GetFruitDataRequest())
            .map { $0.fruit }
            .map {
                self.allFruit = $0
                return $0
            }
    }
}
