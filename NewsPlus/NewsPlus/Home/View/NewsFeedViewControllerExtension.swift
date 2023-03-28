//
//  NewsFeedViewControllerExtension.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-25.
//

import UIKit

// MARK: - UICollectionViewDataSource and UICollectionViewDelegate

extension NewsFeedViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setupCollectionViewForiPad() {
        feedCollectionView.register(
            UINib(nibName: Constants.ViewCells.NewsFeedCollectionCell,
                  bundle: nil),
            forCellWithReuseIdentifier: Constants.ViewCells.NewsFeedCollectionCell)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width/4, height: view.frame.size.width/2)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        feedCollectionView.dataSource = self
        feedCollectionView.delegate = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfCellModels
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.ViewCells.NewsFeedCollectionCell, for: indexPath) as? NewsFeedCollectionCell else {
            fatalError("NewsFeedCollectionCell typecast ")
        }
        let cellModel = viewModel.getCellAtRow(indexPath: indexPath)
        cell.configure(feed: cellModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width/2, height: 330)
    }
}
