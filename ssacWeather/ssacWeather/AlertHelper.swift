//
//  AlertHelper.swift
//  ssacWeather
//
//  Created by 강호성 on 2021/10/26.
//

import UIKit

typealias Action = () -> ()

class AlertHelper {
    
    static func setAlert(title: String?, message: String?, okMessage: String, over viewController: UIViewController) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: okMessage, style: .default, handler: nil))
        viewController.present(ac, animated: true)
    }
    
    static func okHandlerAlert(title: String, message: String?, onConfirm: @escaping Action, over viewController: UIViewController) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { (_) in
            onConfirm()
        })
        
        let noAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        ac.addAction(okAction)
        ac.addAction(noAction)
        viewController.present(ac, animated: true)
    }
}
