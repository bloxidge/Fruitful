//
//  FruitDataResponse.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 23/05/2021.
//

import Foundation

struct FruitDataResponse: Decodable {
    let fruit: [Fruit]
}

class GetFruitDataRequest: Request<FruitDataResponse> {
    
    override var path: String {
        return "data.json"
    }
    
    override var headers: [HttpHeader] {
        return [.contentType(.json)]
    }
}
