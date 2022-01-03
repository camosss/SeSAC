//
//  PostViewModel.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/31.
//

import UIKit

struct PostViewModel {
    var content: String?
    
    var formIsValid: Bool {
        return content?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? .systemGreen : .white
    }
    
    var buttonTitleColor: UIColor {
        return formIsValid ? .systemGreen : .systemGray6
    }
    
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
