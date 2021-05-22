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
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.font = titleLabel.font.withSize(bounds.height / 4)
    }
}
