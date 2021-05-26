//
//  FruitListCollectionViewCell.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import UIKit

@IBDesignable
class FruitListCollectionViewCell: UICollectionViewCell, NibBackedView {

    @IBOutlet
    private var titleLabel: UILabel!
    
    @IBInspectable
    var title: String? {
        willSet {
            titleLabel.text = newValue?.capitalized
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleViews()
    }
    
    private func styleViews() {
        titleLabel.font = .cellStyle()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        styleViews()
    }
}
