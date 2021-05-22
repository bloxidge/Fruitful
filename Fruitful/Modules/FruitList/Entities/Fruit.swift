//
//  Fruit.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import Foundation

struct Fruit {
    let type: String
    let price: UInt
    let weight: UInt
    
    var priceInPoundsAndPence: Double { Double(price) / 100 }
    var weightInKg: Double { Double(weight) / 1000 }
}


