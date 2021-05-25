//
//  FruitDetailView.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import Foundation

protocol FruitDetailView: AutoMockable {
    func showDetails(for fruit: Fruit)
}
