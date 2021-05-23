//
//  FruitListViewController.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import UIKit

class FruitListViewController: UIViewController {
    
    struct Constants {
        static let cellSpacing: CGFloat = 16
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var presenter: FruitListPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        
        presenter.reload()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func presentErrorAlert(message: String) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
            self?.presenter.reload()
        }
        alertController.addAction(cancelAction)
        alertController.addAction(retryAction)
        present(alertController, animated: true)
    }
}

extension FruitListViewController: FruitListView {
    
    func showLoading() {
        activityIndicator.startAnimating()
        collectionView.isHidden = true
    }
    
    func showFruitList() {
        activityIndicator.stopAnimating()
        collectionView.reloadData()
        collectionView.isHidden = false
    }
    
    func showError() {
        activityIndicator.stopAnimating()
        collectionView.isHidden = true
        presentErrorAlert(message: "Oops, something went wrong. Please try again.")
    }
}

extension FruitListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getFruitCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FruitListCollectionViewCell",
                                                      for: indexPath) as! FruitListCollectionViewCell
        let fruit = presenter.getFruit(at: indexPath.item)
        cell.title = fruit?.type
        return cell
    }
}

extension FruitListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedFruit = presenter.getFruit(at: indexPath.item) {
            presenter.didSelect(fruit: selectedFruit)
        }
    }
}

extension FruitListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isPortrait = collectionView.bounds.width < collectionView.bounds.height
        let cellsPerRow: CGFloat = isPortrait ? 2 : 4
        let width = (collectionView.bounds.width - (Constants.cellSpacing * (cellsPerRow - 1))) / cellsPerRow
        return CGSize(width: width, height: width * 0.75)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constants.cellSpacing
    }
}



