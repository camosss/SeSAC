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
        view.backgroundColor = .purple
    }

    // Analytics 구현해보기
//    override func viewWillAppear(_ animated: Bool) {
//        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
//          AnalyticsParameterItemID: "id-\(title!)",
//          AnalyticsParameterItemName: title!,
//          AnalyticsParameterContentType: "cont",
//        ])
//    }

}

