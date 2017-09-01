//
//  WTCarouselFlowLayout.swift
//  Pods
//
//  Created by wentianen on 2017/8/31.
//
//

import UIKit

public enum WTCarouselFlowLayoutSpacingMode {
    case between(spacing: CGFloat)          // between items spacing
    case overlap(overlapSpacing: CGFloat)   // two items overlap spacing
}

public enum WTCarouselFlowLayoutBaselineType: Int {
    case top
    case center
    case bottom
}

public class WTCarouselFlowLayout: UICollectionViewFlowLayout {
    /**
     * beside item scale to show
     * value range 0-1,default value 0.7
     */
    @IBInspectable open var sideItemScale: CGFloat = 0.7
    /**
     * beside item alpha to show
     * value range 0-1,default value 0.7
     */
    @IBInspectable open var sideItemAlpha: CGFloat = 0.7

    /**
     * to control minimumLineSpacing
     */
    open var spacingMode = WTCarouselFlowLayoutSpacingMode.between(spacing: 20)
    /**
     * scroll direction beside items baseline type
     */
    @IBInspectable open var sideItemBaselineType = WTCarouselFlowLayoutBaselineType.center
    /**
     * base on sideItemBaselineType, you can adjust the baseline offset by this value
     */
    @IBInspectable open var sideItemOffset: CGFloat = 0.0

    override open func prepare() {
        super.prepare()

        self.setupCollectionView()
        self.updateLayout()
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
        let isHorizontal = (scrollDirection == .horizontal)

        let yInset = (collectionSize.height - itemSize.height) / 2 * 0
        let xInset = (collectionSize.width - itemSize.width) / 2
        self.sectionInset = UIEdgeInsets(top: yInset, left: xInset, bottom: yInset, right: xInset)

        let scrollDirectionItemWidth = isHorizontal ? itemSize.width : itemSize.height
        let scaledItemOffset = (scrollDirectionItemWidth - scrollDirectionItemWidth * self.sideItemScale) / 2
        switch spacingMode {
        case .between(let spacing):
            self.minimumLineSpacing = spacing - scaledItemOffset
        case .overlap(let visibleOffset):
            let fullSizeSideItemOverlap = visibleOffset + scaledItemOffset
            self.minimumLineSpacing = -fullSizeSideItemOverlap
        }
    }

    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let superAttributes = super.layoutAttributesForElements(in: rect), let attributes = NSArray(array: superAttributes, copyItems: true) as? [UICollectionViewLayoutAttributes] else {
            return nil
        }
        return attributes.map({ self.transformLayoutAttributes($0) })
    }

    fileprivate func transformLayoutAttributes(_ attributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        guard let collectionView = self.collectionView else { return attributes }
        let isHorizontal = (self.scrollDirection == .horizontal)

        let collectionCenter = isHorizontal ? collectionView.frame.size.width / 2 : collectionView.frame.size.height / 2
        let offset = isHorizontal ? collectionView.contentOffset.x : collectionView.contentOffset.y
        let normalizedCenter = (isHorizontal ? attributes.center.x : attributes.center.y) - offset

        let maxDistance = (isHorizontal ? self.itemSize.width : self.itemSize.height) + self.minimumLineSpacing
        let distance = min(abs(collectionCenter - normalizedCenter), maxDistance)
        let ratio = (maxDistance - distance) / maxDistance

        let alpha = ratio * (1 - self.sideItemAlpha) + self.sideItemAlpha
        let scale = ratio * (1 - self.sideItemScale) + self.sideItemScale
        attributes.alpha = alpha
        attributes.transform3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
        attributes.zIndex = Int(alpha * 10)

        let scrollDirectionItemHeight = isHorizontal ? itemSize.height : itemSize.width
        var sideItemFixedOffset: CGFloat = 0
        switch sideItemBaselineType {
        case .top:
            sideItemFixedOffset = -(scrollDirectionItemHeight - scrollDirectionItemHeight * self.sideItemScale) / 2
        case .center:
            sideItemFixedOffset = 0
        case .bottom:
            sideItemFixedOffset = (scrollDirectionItemHeight - scrollDirectionItemHeight * self.sideItemScale) / 2
        }
        let shift = (1 - ratio) * (sideItemOffset + sideItemFixedOffset)
        if isHorizontal {
            attributes.center.y += shift
        } else {
            attributes.center.x += shift
        }
        
        return attributes
    }

    override open func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView , !collectionView.isPagingEnabled,
            let layoutAttributes = self.layoutAttributesForElements(in: collectionView.bounds)
            else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset) }

        let isHorizontal = (self.scrollDirection == .horizontal)

        let midSide = (isHorizontal ? collectionView.bounds.size.width : collectionView.bounds.size.height) / 2
        let proposedContentOffsetCenterOrigin = (isHorizontal ? proposedContentOffset.x : proposedContentOffset.y) + midSide

        var targetContentOffset: CGPoint
        if isHorizontal {
            let closest = layoutAttributes.sorted { abs($0.center.x - proposedContentOffsetCenterOrigin) < abs($1.center.x - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: floor(closest.center.x - midSide), y: proposedContentOffset.y)
        } else {
            let closest = layoutAttributes.sorted { abs($0.center.y - proposedContentOffsetCenterOrigin) < abs($1.center.y - proposedContentOffsetCenterOrigin) }.first ?? UICollectionViewLayoutAttributes()
            targetContentOffset = CGPoint(x: proposedContentOffset.x, y: floor(closest.center.y - midSide))
        }

        return targetContentOffset
    }
}
