//
//  RegisterViewController.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/30.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Properties
    
    let signView = SignView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = signView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "새싹농장 회원가입"
        
        signView.loginButton.setTitle("회원가입", for: .normal)
    }
}
