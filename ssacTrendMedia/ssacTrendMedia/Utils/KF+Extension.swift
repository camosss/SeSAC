//
//  ExtensionKingfisher.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/18.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
