//
//  PostAnalyticsEventRequest.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 24/05/2021.
//

import Foundation

class PostAnalyticsEventRequest: Request<EmptyResponse> {
    
    override var method: HttpMethod {
        return .post
    }
    
    override var path: String {
        return "stats"
    }
    
    override var queryParameters: [String : String]? {
        return event.params
    }
    
    private let event: AnalyticsEvent
    
    init(event: AnalyticsEvent) {
        self.event = event
    }
}
