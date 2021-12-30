//
//  FeedViewModel.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/31.
//

import UIKit

struct FeedViewModel {
    
    // dynamic content height
    func size(forWidth width: CGFloat) -> CGSize {
        let measurementLabel = UILabel()
//        measurementLabel.text = tweet.caption
        measurementLabel.numberOfLines = 0
        measurementLabel.lineBreakMode = .byWordWrapping
        measurementLabel.translatesAutoresizingMaskIntoConstraints = false
        measurementLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return measurementLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
