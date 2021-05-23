//
//  ApiService.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 23/05/2021.
//

import Foundation
import PromiseKit
import PMKFoundation

protocol ApiService {
    func send<ResponseType: Decodable>(request: Request<ResponseType>) -> Promise<ResponseType>
}

class ApiServiceImpl: ApiService {
        
    private let baseUrl = "https://raw.githubusercontent.com/fmtvp/recruit-test-data/master/"
    
    let requestBuilder: URLRequestBuilder
    let urlSession: URLSession
    
    init(requestBuilder: URLRequestBuilder,
         urlSession: URLSession = .shared) {
        self.requestBuilder = requestBuilder
        self.urlSession = urlSession
    }
    
    func send<ResponseType>(request: Request<ResponseType>) -> Promise<ResponseType> where ResponseType : Decodable {
        firstly { () -> Promise<(data: Data, response: URLResponse)> in
            let urlRequest = try requestBuilder.build(from: request, baseUrl: baseUrl)
            return urlSession.dataTask(.promise, with: urlRequest)
        }.map { (data, response) in
            guard let response = response as? HTTPURLResponse else {
                throw ApiError.invalidResponse
            }
            switch response.statusCode {
            case 200..<300:
                return data
            case let code:
                throw PMKHTTPError.badStatusCode(code, data, response)
            }
        }.map { data in
            try request.decode(response: data)
        }
    }
    
    
}