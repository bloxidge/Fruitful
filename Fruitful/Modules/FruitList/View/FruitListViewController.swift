//
//  FruitListViewController.swift
//  Fruitful
//
//  Created by Peter Bloxidge on 22/05/2021.
//

import UIKit

class FruitListViewController: UIViewController {
    
    var presenter: FruitListPresenter!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let cellReuseIdentifier = "FruitListCollectionViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        
        presenter.reload()
    }
    
    private func setUpCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! FruitListCollectionViewCell
        let fruit = presenter.getFruit(at: indexPath.item)
        cell.title = fruit?.type
        return cell
    }
}

extension FruitListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}



