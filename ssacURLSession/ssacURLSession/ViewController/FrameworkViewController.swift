//
//  FrameworkViewController.swift
//  ssacURLSession
//
//  Created by 강호성 on 2021/12/23.
//

import UIKit
import ssacFramework

class FrameworkViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let sesac = SeSACOpen()
        sesac.presentWebViewController(url: "https://www.naver.com", transitionStyle: .present, vc: self)
        
    }
}
