//
//  FruitListView.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import Foundation

enum FruitListViewState: Equatable {
    case initial
    case loading
    case doneResults
    case doneEmpty
    case error
}

protocol FruitListView: AutoMockable {
    func updateView(state: FruitListViewState)
}
