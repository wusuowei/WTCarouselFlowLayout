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

- ```WTCarouselFlowLayoutSpacingMode.overlap(overlapSpacing: 15)```
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

### Carthage

github "wusuowei/WTCarouselFlowLayout"

## Example

Via code

```
import UPCarouselFlowLayout
```

Create a UPCarouselFlowLayout object, set its itemSize and assign it to your UICollectionView.

```
let layout = UPCarouselFlowLayout()
layout.itemSize = CGSizeMake(200, 200)
collectionView.collectionViewLayout = layout
```

## Author

1206860151@qq.com, wentianen@xingshulin.com

## License

WTCarouselFlowLayout is available under the MIT license. See the LICENSE file for more info.
