//
//  AnalyticsEvent.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 24/05/2021.
//

import Foundation

enum AnalyticsEvent {
    
    enum Key: String {
        case event
        case data
    }
    
    case load(time: UInt)
    case display(time: UInt)
    case error(String)
    
    var name: String {
        switch self {
        case .load:    return "load"
        case .display: return "display"
        case .error:   return "error"
        }
    }
    
    var value: String {
        switch self {
        case .load(let time),
             .display(let time):
            return "\(time)"
        case .error(let message):
            return message
        }
    }
    
    var params: [String : String] {
        return [
            Key.event.rawValue : name,
            Key.data.rawValue  : value
        ]
    }
}
