//
//  AnalyticsService.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 24/05/2021.
//

import Foundation
import PromiseKit

protocol AnalyticsService {
    func track(event: AnalyticsEvent)
    func track(screenEvent: Screen.Event)
}

class AnalyticsServiceImpl: AnalyticsService {
    
    static var shared: AnalyticsService = {
        return AnalyticsServiceImpl(requestBuilder: URLRequestBuilderImpl())
    }()
    
    let requestBuilder: URLRequestBuilder
    let urlSession: URLSession
    
    private var pendingScreen: (name: Screen.Name, stamp: Date)?
    
    init(requestBuilder: URLRequestBuilder,
         urlSession: URLSession = .shared) {
        self.requestBuilder = requestBuilder
        self.urlSession = urlSession
    }
    
    func track(event: AnalyticsEvent) {
        send(request: PostAnalyticsEventRequest(event: event))
    }
    
    func track(screenEvent: Screen.Event) {
        switch screenEvent {
        case .requested(let screenName):
            pendingScreen = (screenName, Date())
        case .displayed(let screenName):
            if let pendingScreen = pendingScreen {
                if pendingScreen.name == screenName {
                    let executionTimeMs = Date().timeIntervalSince(pendingScreen.stamp).milliseconds
                    AnalyticsServiceImpl.shared.track(event: .display(time: UInt(executionTimeMs)))
                }
            }
            pendingScreen = nil
        }
    }
    
    @discardableResult
    func send(request: PostAnalyticsEventRequest) -> Promise<Void> {
        firstly { () -> Promise<Void> in
            let urlRequest = try requestBuilder.build(from: request, baseUrl: ApiConfig.baseUrl)
            return urlSession.dataTask(.promise, with: urlRequest).asVoid()
        }
    }
}
