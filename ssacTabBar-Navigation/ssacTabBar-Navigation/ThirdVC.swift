//
//  ThirdVC.swift
//  ssacTabBar-Navigation
//
//  Created by 강호성 on 2021/10/05.
//

import UIKit

class ThirdVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self, #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(self, #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(self, #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(self, #function)
    }
}
