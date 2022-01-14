//
//  StartViewController.swift
//  ssacChatting
//
//  Created by 강호성 on 2022/01/14.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func convertChatVC(_ sender: UIButton) {
        let controller = ChatTableViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
}
