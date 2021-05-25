//
//  FruitListView.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import Foundation

protocol FruitListView: AutoMockable {
    func showLoading()
    func showPopulatedList()
    func showEmptyList()
    func showError()
}
