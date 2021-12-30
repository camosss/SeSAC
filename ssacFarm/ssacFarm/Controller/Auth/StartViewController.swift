//
//  StartViewController.swift
//  ssacFarm
//
//  Created by 강호성 on 2021/12/30.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    // MARK: - Properties
    
    let startPageView = StartPageView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = startPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setAddTarget()
    }
    
    // MARK: - Action
    
    @objc func goToRegisterView() {
        let controller = RegisterViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @objc func goToSignInView() {
        let controller = SignInViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Helper
    
    func setAddTarget() {
        startPageView.startButton.addTarget(self, action: #selector(goToRegisterView), for: .touchUpInside)
        startPageView.alreadyHaveAccountButton.addTarget(self, action: #selector(goToSignInView), for: .touchUpInside)
    }
}
