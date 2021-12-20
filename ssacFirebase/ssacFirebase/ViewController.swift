//
//  ViewController.swift
//  ssacFirebase
//
//  Created by 강호성 on 2021/12/06.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "First"
        view.backgroundColor = .systemTeal
    }

    override func viewWillAppear(_ animated: Bool) {
        // Analytics 구현해보기
//        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
//          AnalyticsParameterItemID: "id-\(title!)",
//          AnalyticsParameterItemName: title!,
//          AnalyticsParameterContentType: "cont",
//        ])
        
        Installations.installations().delete { error in
            if let error = error {
                print("Error deleting installation: \(error)")
                return
            }
            print("Installation deleted")
        }
    }

}

