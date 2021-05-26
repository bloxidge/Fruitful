//
//  FruitDetailViewController.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import UIKit

class FruitDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    var presenter: FruitDetailPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleViews()
        
        presenter.attachToView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        AnalyticsServiceImpl.shared.track(screenEvent: .displayed(.fruitDetail))
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        styleViews()
    }
    
    private func styleViews() {
        titleLabel.font = .detailTitleStyle()
        priceLabel.font = .detailStyle()
        weightLabel.font = .detailStyle()
    }
    
    @IBAction func closePressed() {
        presenter.didPressClose()
    }
}

extension FruitDetailViewController: FruitDetailView {
    
    func updateView(state: FruitDetailViewState) {
        if case .initial(let fruit) = state {
            titleLabel.text = fruit.type.capitalized
            priceLabel.text = String(format: "£ %0.2f", fruit.priceInPoundsAndPence)
            weightLabel.text = String(format: "%0.3f kg", fruit.weightInKg)
        }
    }
}
