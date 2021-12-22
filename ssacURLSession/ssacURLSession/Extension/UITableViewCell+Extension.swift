//
//  UITableViewCell+Extension.swift
//  ssacURLSession
//
//  Created by 강호성 on 2021/12/21.
//

import UIKit

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
