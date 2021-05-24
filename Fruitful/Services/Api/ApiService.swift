//
//  ApiService.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 23/05/2021.
//

import UIKit
import PromiseKit
import PMKFoundation

protocol ApiService {
    func send<ResponseType: Decodable>(request: Request<ResponseType>) -> Promise<ResponseType>
}

class ApiServiceImpl: ApiService {
    
    let requestBuilder: URLRequestBuilder
    let urlSession: URLSession
    let analytics: AnalyticsService
    
    init(requestBuilder: URLRequestBuilder,
         urlSession: URLSession = .shared) {
        self.requestBuilder = requestBuilder
        self.urlSession = urlSession
        self.analytics = AnalyticsServiceImpl.shared
    }
    
    func send<ResponseType>(request: Request<ResponseType>) -> Promise<ResponseType> where ResponseType : Decodable {
        var start, end: Date?
        
        return firstly { () -> Promise<(data: Data, response: URLResponse)> in
            let urlRequest = try requestBuilder.build(from: request, baseUrl: ApiConfig.baseUrl)
            
            start = Date()
            
            return urlSession.dataTask(.promise, with: urlRequest)
        }
        .map { (data, response) in
            end = Date()
            
            guard let response = response as? HTTPURLResponse else {
                throw ApiError.invalidResponse
            }
            
            switch response.statusCode {
            case 200..<300:
                return data
            case let code:
                throw PMKHTTPError.badStatusCode(code, data, response)
            }
        }
        .map { data in
            try request.decode(response: data)
        }
        .ensure { [weak self] in
            guard let start = start, let end = end else { return }
            let executionTimeMs = end.timeIntervalSince(start).milliseconds
            self?.analytics.track(event: .load(time: UInt(executionTimeMs)))
        }
    }
}
