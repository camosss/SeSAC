//
//  UIImage+Extension.swift
//  ssacBeer
//
//  Created by 강호성 on 2021/12/22.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
