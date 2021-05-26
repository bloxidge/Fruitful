//
//  FruitDetailPresenterTests.swift
//  FruitfulTests
//
//  Created by Peter Bloxidge on 25/05/2021.
//

import XCTest
@testable import Fruitful
import SwiftyMocky

class FruitDetailPresenterTests: XCTestCase {
    
    var sut: FruitDetailPresenter!
    
    let view = FruitDetailViewMock()
    let router = FruitDetailRouterMock()
    
    private let fruitStub = FruitFixtures.fruitResults[4]

    override func setUp() {
        super.setUp()
        
        let presenter = FruitDetailPresenterImpl(fruit: fruitStub)
        presenter.view = view
        presenter.router = router
        
        sut = presenter
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testOnViewDidLoad() {
        // When
        //   Presenter is attached to view
        sut.attachToView()

        // Then
        //   View should get an .initial state update callback with selected fruit as associated value
        Verify(view, .updateView(state: .value(.initial(fruitStub))))
    }
    
    func testDidPressClose() {
        // When
        //   Presenter receives close button pressed
        sut.didPressClose()
        
        // Then
        //   Router should dismiss detail screen
        Verify(router, .dismissDetail())
    }
}
