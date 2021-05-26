//
//  FruitFixtures.swift
//  FruitfulTests
//
//  Created by Peter Bloxidge on 25/05/2021.
//

import Foundation
@testable import Fruitful

struct FruitFixtures {
    
    static let response = FruitDataResponse(fruit: fruitResults)
    
    static let fruitResults = [
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
}
