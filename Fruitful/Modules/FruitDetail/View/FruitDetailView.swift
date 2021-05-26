//
//  FruitDetailView.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import Foundation

enum FruitDetailViewState: Equatable {
    case initial(Fruit)
}

protocol FruitDetailView: AutoMockable {
    func updateView(state: FruitDetailViewState)
}
