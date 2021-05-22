//
//  UIViewController+storyboard.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import UIKit

extension UIViewController {
    
    static func instantiateFromStoryboard(name: String) -> Self {
        let id = String(describing: Self.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
