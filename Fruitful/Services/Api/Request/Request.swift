//
//  Request.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 23/05/2021.
//

import Foundation

class Request<ResponseType: Decodable> {
        
    var method: HttpMethod {
        return .get
    }
    
    var path: String {
        fatalError("Must override path")
    }
    
    var headers: [HttpHeader] {
        return []
    }
    
    var queryParameters: [String : String]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }

    final func decode(response: Data,
                      using decoder: JSONDecoder = JSONDecoder()) throws -> ResponseType {
        return try decoder.decode(ResponseType.self, from: response)
    }
}

struct EmptyResponse: Decodable {}
