//
//  KF+Extension.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/03.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
