//
//  AnalyticsService.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 24/05/2021.
//

import Foundation

protocol AnalyticsService {
    func track(event: AnalyticsEvent)
}

class AnalyticsServiceImpl: AnalyticsService {
    
    let api: ApiService
    
    init(api: ApiService) {
        self.api = api
    }
    
    func track(event: AnalyticsEvent) {
        api.send(request: PostAnalyticsEventRequest(event: event))
            .cauterize()
    }
}
