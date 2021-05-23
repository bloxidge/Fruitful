//
//  RoundedBorderButton.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 23/05/2021.
//

import UIKit

@IBDesignable
class RoundedBorderButton: UIButton {
    
    @IBInspectable
    override var borderWidth: CGFloat {
        didSet {
            updateUI()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        updateUI()
    }
    
    private func updateUI() {
        cornerRadius = 4
        borderColor = currentTitleColor
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            updateUI()
        }
    }
}
