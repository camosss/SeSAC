//
//  SignInViewController.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/30.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - Properties
    
    let signView = SignView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = signView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "새싹농장 로그인"
        
        setSignView()
    }
    
    // MARK: - Action
    
    
    
    // MARK: - Helper
    
    func setSignView() {
        signView.loginButton.setTitle("로그인", for: .normal)
        signView.nameContainerView.isHidden = true
        signView.rePasswordContainerView.isHidden = true
    }
    
}
