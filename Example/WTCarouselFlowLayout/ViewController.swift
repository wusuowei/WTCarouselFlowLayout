//
//  ViewController.swift
//  WTCarouselFlowLayout
//
//  Created by 1206860151@qq.com on 08/31/2017.
//  Copyright (c) 2017 1206860151@qq.com. All rights reserved.
//

import UIKit
import WTCarouselFlowLayout

class ViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descriptionLabel: UILabel!

    var selectedIndex = 0

    let movieList = MovieModel.movieModels()
    var pageSize: CGSize {
        let layout = self.collectionView.collectionViewLayout as! WTCarouselFlowLayout
        var pageSize = layout.itemSize
        pageSize.width += layout.minimumLineSpacing
        return pageSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupFlowLayout()
        refreshView()
    }

    func setupFlowLayout() {
        let layout = self.collectionView.collectionViewLayout as! WTCarouselFlowLayout
        layout.itemSize = CGSize(width: 85, height: 125)
        layout.scrollDirection = .horizontal
//        layout.spacingMode = WTCarouselFlowLayoutSpacingMode.between(spacing: 15)
        layout.spacingMode = WTCarouselFlowLayoutSpacingMode.overlap(overlapSpacing: 15)
        layout.sideItemScale = 0.7
        layout.sideItemAlpha = 0.7
        layout.sideItemBaselineType = .bottom
        layout.sideItemOffset = 0.0
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.model = movieList[indexPath.row]
        return cell
    }

    func refreshView() {
        guard selectedIndex < movieList.count else {
            return
        }
        let model = movieList[selectedIndex]
        self.titleLabel.text = model.title
        self.descriptionLabel.text = model.detail
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition.centeredHorizontally, animated: true)
        selectedIndex = indexPath.row
        refreshView()
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageSide = self.pageSize.width
        let offset = scrollView.contentOffset.x
        selectedIndex = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        refreshView()
    }
}

