//
//  WTCarouselFlowLayout.swift
//  Pods
//
//  Created by wentianen on 2017/8/31.
//
//

import UIKit

public enum WTCarouselFlowLayoutSpacingMode {
    case fixed(spacing: CGFloat)
    case overlap(visibleOffset: CGFloat)
}

class WTCarouselFlowLayout: UICollectionViewFlowLayout {
    fileprivate struct LayoutState {
        var size: CGSize
        var direction: UICollectionViewScrollDirection
        func isEqual(_ otherState: LayoutState) -> Bool {
            return self.size.equalTo(otherState.size) && self.direction == otherState.direction
        }
    }

    @IBInspectable open var sideItemScale: CGFloat = 0.7
    @IBInspectable open var sideItemAlpha: CGFloat = 0.7
    @IBInspectable open var sideItemShift: CGFloat = 0.0
    open var spacingMode = WTCarouselFlowLayoutSpacingMode.fixed(spacing: 40)

    fileprivate var state = LayoutState(size: CGSize.zero, direction: .horizontal)

    override open func prepare() {
        super.prepare()

        let currentState = LayoutState(size: self.collectionView!.bounds.size, direction: self.scrollDirection)

        if !self.state.isEqual(currentState) {
            self.setupCollectionView()
            self.updateLayout()
            self.state = currentState
        }
    }

    fileprivate func setupCollectionView() {
        guard let collectionView = self.collectionView else { return }
        if collectionView.decelerationRate != UIScrollViewDecelerationRateFast {
            collectionView.decelerationRate = UIScrollViewDecelerationRateFast
        }
    }

    fileprivate func updateLayout() {
        guard let collectionView = self.collectionView else { return }

        let collectionSize = collectionView.bounds.size
        let isHorizontal = (self.scrollDirection == .horizontal)

        let yInset = (collectionSize.height - self.itemSize.height) / 2
        let xInset = (collectionSize.width - self.itemSize.width) / 2
        self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)

        let side = isHorizontal ? self.itemSize.width : self.itemSize.height
        let scaledItemOffset = (side - side*self.sideItemScale) / 2
        let itemSpace: CGFloat = 10
        switch self.spacingMode {
        case .fixed(let spacing):
            self.minimumLineSpacing = spacing - scaledItemOffset
        case .overlap(let visibleOffset):
            let fullSizeSideItemOverlap = visibleOffset + scaledItemOffset
            let inset = itemSpace
            self.minimumLineSpacing = inset - fullSizeSideItemOverlap
        }
    }

    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect),
            let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes]
            else { return nil }
        return attributes.map({ self.transformLayoutAttributes($0) })
    }

    fileprivate func transformLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        let isHorizontal = (self.scrollDirection == .horizontal)

        let collectionCenter = isHorizontal ? collectionView.frame.size.width/2 : collectionView.frame.size.height/2
        let offset = isHorizontal ? collectionView.contentOffset.x : collectionView.contentOffset.y
        let normalizedCenter = (isHorizontal ? attributes.center.x : attributes.center.y) - offset

        let maxDistance = (isHorizontal ? self.itemSize.width : self.itemSize.height) + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance)/maxDistance

        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        let shift = (1 - ratio) * self.sideItemShift
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(alpha * 10)

        if isHorizontal {
            attributes.center.y += shift
        } else {
            attributes.center.x += shift
        }
        
        return attributes
    }
}
