//
//  FruitListPresenterTests.swift
//  FruitfulTests
//
//  Created by Peter Bloxidge on 25/05/2021.
//

import XCTest
@testable import Fruitful
import PromiseKit
import SwiftyMocky

class FruitListPresenterTests: XCTestCase {
    
    var sut: FruitListPresenter!
    
    let view = FruitListViewMock()
    let interactor = FruitListInteractorMock()
    let router = FruitListRouterMock()

    override func setUp() {
        super.setUp()
        
        let presenter = FruitListPresenterImpl()
        presenter.view = view
        presenter.interactor = interactor
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
        //   View should get an .initial state update callback
        Verify(view, .updateView(state: .value(.initial)))
    }
    
    func testReloadNotShowLoadingState() {
        // Given
        //   Interactor will return anything
        Given(interactor, .fetchAllFruit(willReturn: .pending().promise))
        
        // When
        //   Presenter is requested to reload data without showing loading state
        sut.reload(showLoading: false)

        // Then
        //   View should not get a `.loading` state update callback
        Verify(view, 0, .updateView(state: .value(.loading)))
    }
    
    func testReloadSuccessPopulatedResultsState() {
        // Given
        //   Interactor returns non-empty results
        Given(interactor, .fetchAllFruit(willReturn: Promise.value(FruitFixtures.fruitResults)))
        
        // When
        //   Presenter is requested to reload data
        waitFor(sut.reload(showLoading: true))

        // Then
        //   View should receive view state update callbacks for `.loading` and `.doneResults`
        Verify(view, .updateView(state: .value(.loading)))
        Verify(view, .updateView(state: .value(.doneResults)))
    }
    
    func testReloadSuccessEmptyResultsState() {
        // Given
        //   Interactor returns no results
        Given(interactor, .fetchAllFruit(willReturn: Promise.value([])))
        
        // When
        //   Presenter is requested to reload data
        waitFor(sut.reload(showLoading: true))

        // Then
        //   View should receive view state update callbacks for `.loading` and `.doneEmpty`
        Verify(view, .updateView(state: .value(.loading)))
        Verify(view, .updateView(state: .value(.doneEmpty)))
    }
    
    func testReloadFailedErrorState() {
        // Given
        //   Interactor returns an error
        Given(interactor, .fetchAllFruit(willReturn: Promise(error: ApiError.invalidResponse)))
        
        // When
        //   Presenter is requested to reload data
        waitFor(sut.reload(showLoading: true))

        // Then
        //   View should receive view state update callbacks for `.loading` and `.doneEmpty`
        Verify(view, .updateView(state: .value(.loading)))
        Verify(view, .updateView(state: .value(.error)))
    }
    
    func testGetFruitCount() {
        // Given
        //   Interactor has cached value for `allFruit`
        Given(interactor, .allFruit(getter: FruitFixtures.fruitResults))
        
        // Then
        //   Method should return count for `allFruit`
        XCTAssertEqual(sut.getFruitCount(), FruitFixtures.fruitResults.count)
    }
    
    func testGetFruitAtIndex() {
        // Given
        //   Interactor has cached value for `allFruit`
        Given(interactor, .allFruit(getter: FruitFixtures.fruitResults))
        
        // Then
        //   Method should return fruit at index in `allFruit`
        XCTAssertEqual(sut.getFruit(at: 5), FruitFixtures.fruitResults[5])
    }
    
    func testDidSelectFruit() {
        let selectedFruit = FruitFixtures.fruitResults[2]
        
        // When
        //   Presenter receives selected fruit
        sut.didSelect(fruit: selectedFruit)

        // Then
        //   Router should present detail screen for selected fruit
        Verify(router, .presentDetail(for: .value(selectedFruit)))
    }
}
