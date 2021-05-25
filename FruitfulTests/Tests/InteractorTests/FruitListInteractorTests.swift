//
//  FruitListInteractorTests.swift
//  FruitfulTests
//
//  Created by Peter Bloxidge on 25/05/2021.
//

import XCTest
@testable import Fruitful
import PromiseKit
import SwiftyMocky

class FruitListInteractorTests: XCTestCase {
    
    var sut: FruitListInteractor!
    
    let apiMock = ApiServiceMock()

    override func setUp() {
        super.setUp()
        
        sut = FruitListInteractorImpl(api: apiMock)
    }
    
    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }
    
    func testfetchAllFruitRequestValid() {
        // Given
        //   API will return valid response
        Given(apiMock, .send(request: .any(Request<FruitDataResponse>.self),
                             willReturn: Promise.value(FruitFixtures.response)))
        
        // When
        //   fetchAllFruit method called
        waitFor(sut.fetchAllFruit())

        // Then
        //   It should send a correct request
        let matcher = RequestMatcher<FruitDataResponse>(method: .get,
                                                        path: "data.json")
        Verify(apiMock, .send(request: matcher.getParameter()))
    }
    
    func testfetchAllFruitSuccess() {
        // Given
        //   API will return valid response
        let expectedResponse = FruitFixtures.response
        Given(apiMock, .send(request: .any(Request<FruitDataResponse>.self),
                             willReturn: Promise.value(expectedResponse)))
        
        // When
        //   fetchAllFruit method called
        var capturedResult: [Fruit]?
        var capturedError: Error?
        waitFor(sut.fetchAllFruit(), &capturedResult, &capturedError)

        // Then
        //   It should return correct result
        XCTAssertEqual(capturedResult, expectedResponse.fruit)

        // And
        //   It should not throw an error
        XCTAssertNil(capturedError)
        
        // And
        //   Result should be cached in local variable
        XCTAssertEqual(sut.allFruit, capturedResult)
    }
    
    func testfetchAllFruitError() {
        // Given
        //   API will return an error
        Given(apiMock, .send(request: .any(Request<FruitDataResponse>.self),
                             willReturn: Promise(error: ApiError.invalidResponse)))
        
        // When
        //   fetchAllFruit method called
        var capturedResult: [Fruit]?
        var capturedError: Error?
        waitFor(sut.fetchAllFruit(), &capturedResult, &capturedError)
        
        // Then
        //   It should throw an error
        XCTAssertNotNil(capturedError)

        // And
        //   It should not return a valid result
        XCTAssertNil(capturedResult)
        
        // And
        //   Result should not be cached in local variable
        XCTAssertNil(sut.allFruit)
    }
}
