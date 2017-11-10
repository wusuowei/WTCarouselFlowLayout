//
//  MovieModel.swift
//  WTCarouselFlowLayout
//
//  Created by 温天恩 on 2017/8/31.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit

class MovieModel: NSObject {
    @objc var title = ""
    @objc var imageName = ""
    @objc var detail = ""

    @objc class func movieModels() -> [MovieModel] {
        var models = [MovieModel]()
        for i in 0...6 {
            let model = MovieModel()
            model.title = "第\(i)部电影"
            model.imageName = "\(i).jpeg"
            model.detail = "第\(i)部电影是一部很精彩的电影， 讲述了一个脑残和另外一个脑残一起打败一帮脑残的故事。。。☺\n故事的经过曲折离奇，扣人心弦。。。\n故事的结局。。。"
            models.append(model)
        }
        return models
    }
}
