//
//  UIAlert+Extension.swift
//  ssacFarm
//
//  Created by 강호성 on 2022/01/03.
//

import UIKit

typealias Action = () -> ()

class AlertHelper {
    
    static func actionSheetAlert(first: String, second: String, onFirst: @escaping (Action), onSecond: @escaping (Action), over viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let edit = UIAlertAction(title: first, style: .default) { _ in
            onFirst()
        }
        
        let delete = UIAlertAction(title: second, style: .destructive) { _ in
            onSecond()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(edit)
        alert.addAction(delete)
        alert.addAction(cancel)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func confirmAlert(title: String, message: String?, okMessage: String,onConfirm: @escaping Action, over viewController: UIViewController) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okMessage, style: .default, handler: { (_) in
            onConfirm()
        })
        
        let noAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(noAction)
        viewController.present(ac, animated: true)
    }
}
