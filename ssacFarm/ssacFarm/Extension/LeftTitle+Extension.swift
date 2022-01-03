//
//  LeftTitle+Extension.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/31.
//

import UIKit

extension UIViewController {
    func configureLeftTitle(title: String) {
        let label = UILabel()
        label.textColor = UIColor.black
        label.text = title
        label.font = UIFont.boldSystemFont(ofSize: 24)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: label)
        self.navigationItem.leftItemsSupplementBackButton = true
    }
}
