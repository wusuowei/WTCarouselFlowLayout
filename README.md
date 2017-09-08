# WTCarouselFlowLayout

[![CI Status](http://img.shields.io/travis/1206860151@qq.com/WTCarouselFlowLayout.svg?style=flat)](https://travis-ci.org/1206860151@qq.com/WTCarouselFlowLayout)
[![Version](https://img.shields.io/cocoapods/v/WTCarouselFlowLayout.svg?style=flat)](http://cocoapods.org/pods/WTCarouselFlowLayout)
[![License](https://img.shields.io/cocoapods/l/WTCarouselFlowLayout.svg?style=flat)](http://cocoapods.org/pods/WTCarouselFlowLayout)
[![Platform](https://img.shields.io/cocoapods/p/WTCarouselFlowLayout.svg?style=flat)](http://cocoapods.org/pods/WTCarouselFlowLayout)

**WTCarouselFlowLayout** is flow layout for **UICollectionView**.

- ```WTCarouselFlowLayoutBaselineType.top```

	![image](./DemoResources/CarouselTop.gif)

- ```WTCarouselFlowLayoutBaselineType.center```

	![image](./DemoResources/CarouselCenter.gif)

- ```WTCarouselFlowLayoutBaselineType.bottom```

	![image](./DemoResources/CarouselBottom.gif)

- ```layout.itemSpacing = -15```

	![image](./DemoResources/CarouselOverlap.gif)


## Requirements

- iOS 8.0+

## Installation

### CocoaPods

WTCarouselFlowLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "WTCarouselFlowLayout"
```

## Example

Via code

```
import WTCarouselFlowLayout
```

Create a WTCarouselFlowLayout object, set its itemSize and assign it to your UICollectionView.

```
let layout = self.collectionView.collectionViewLayout as! WTCarouselFlowLayout
layout.itemSize = CGSize(width: 70, height: 100)
layout.scrollDirection = .horizontal
layout.itemSpacing = 15
//  layout.itemSpacing = -15
layout.sideItemScale = 0.7
layout.sideItemAlpha = 0.7
layout.sideItemBaselineType = .center
layout.sideItemOffset = 0.0
```

## detail

[iOS UICollectionView 卡片效果 传送带效果](http://www.jianshu.com/p/1a45ecdc2d5c)

## Author

wentianen, 1206860151@qq.com

## License

WTCarouselFlowLayout is available under the MIT license. See the LICENSE file for more info.
