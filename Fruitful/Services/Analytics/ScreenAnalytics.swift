//
//  ScreenAnalytics.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 24/05/2021.
//

import Foundation

enum Screen {
    
    enum Event: Equatable {
        case requested(Name)
        case displayed(Name)
    }
    
    enum Name: Equatable {
        case fruitList
        case fruitDetail
    }
}
