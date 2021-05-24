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
}

class AnalyticsServiceImpl: AnalyticsService {
    
    let requestBuilder: URLRequestBuilder
    let urlSession: URLSession
    
    init(requestBuilder: URLRequestBuilder,
         urlSession: URLSession = .shared) {
        self.requestBuilder = requestBuilder
        self.urlSession = urlSession
    }
    
    func track(event: AnalyticsEvent) {
        send(request: PostAnalyticsEventRequest(event: event))
    }
    
    @discardableResult
    func send(request: PostAnalyticsEventRequest) -> Promise<Void> {
        firstly { () -> Promise<Void> in
            let urlRequest = try requestBuilder.build(from: request, baseUrl: ApiConfig.baseUrl)
            return urlSession.dataTask(.promise, with: urlRequest).asVoid()
        }
    }
}
