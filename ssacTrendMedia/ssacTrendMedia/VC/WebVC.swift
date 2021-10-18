//
//  WebVC.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/18.
//

import UIKit

class WebVC: UIViewController {
    
    // MARK: - Properties
    
    var navigationTitle = ""

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---\(navigationTitle)")
        title = navigationTitle
        
    }
}
