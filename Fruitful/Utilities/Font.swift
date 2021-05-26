//
//  Font.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 26/05/2021.
//

import UIKit

extension UIFont {
    
    enum FuturaFontWeight: String {
        case medium
        case bold
        case condensedMedium
        case condensedExtraBold
    }
    
    private static func futuraFont(ofSize size: CGFloat, weight: FuturaFontWeight = .medium) -> UIFont {
        return UIFont(name: "Futura-\(weight.rawValue.capitalized)", size: size) ?? .systemFont(ofSize: size)
    }
    
    private static func makeAccessible(font: UIFont, textStyle: TextStyle, maxPointSize: CGFloat? = nil) -> UIFont {
        if let maxPointSize = maxPointSize {
            return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font, maximumPointSize: maxPointSize)
        } else {
            return UIFontMetrics(forTextStyle: textStyle).scaledFont(for: font)
        }
    }
    
    static func titleStyle(size: CGFloat = 32) -> UIFont {
        return makeAccessible(font: futuraFont(ofSize: size, weight: .bold),
                              textStyle: .headline,
                              maxPointSize: 60)
    }
    
    static func cellStyle(size: CGFloat = 28) -> UIFont {
        return makeAccessible(font: futuraFont(ofSize: size, weight: .condensedMedium),
                              textStyle: .body,
                              maxPointSize: 48)
    }
    
    static func detailTitleStyle(size: CGFloat = 32) -> UIFont {
        return makeAccessible(font: futuraFont(ofSize: size, weight: .condensedExtraBold),
                              textStyle: .subheadline)
    }
    
    static func detailStyle(size: CGFloat = 20) -> UIFont {
        return makeAccessible(font: futuraFont(ofSize: size),
                              textStyle: .body)
    }
}
