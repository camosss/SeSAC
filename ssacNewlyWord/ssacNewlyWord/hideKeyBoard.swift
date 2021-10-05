//
//  hideKeyBoard.swift
//  ssacNewlyWord
//
//  Created by 강호성 on 2021/10/02.
//

import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self,
                                                                  action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
