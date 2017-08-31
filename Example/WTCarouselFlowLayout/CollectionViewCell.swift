//
//  CollectionViewCell.swift
//  WTCarouselFlowLayout
//
//  Created by 温天恩 on 2017/8/31.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView()

    var model = MovieModel() {
        didSet {
            if !self.subviews.contains(self.imageView) {
                addSubview(self.imageView)
            }
            self.imageView.frame = self.bounds
            self.imageView.backgroundColor = UIColor.red
            self.imageView.image = UIImage(named: model.imageName)
        }
    }
}
