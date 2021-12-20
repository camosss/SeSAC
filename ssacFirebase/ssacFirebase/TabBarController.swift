//
//  TabBarController.swift
//  ssacFirebase
//
//  Created by 강호성 on 2021/12/20.
//

import UIKit

class TabBarController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    
    // MARK: - Helpers
    
    func configureViewController() {
        tabBar.barTintColor = .white
        tabBar.backgroundColor = .white
        
        let first = templateNavigationController(image: UIImage(systemName: "person")!, rootViewController: ViewController())
        let second = templateNavigationController(image: UIImage(systemName: "plus.app")!, rootViewController: SecondViewController())
        
        viewControllers = [first, second]
    }
    
    func templateNavigationController(image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.tintColor = .black
        return nav
    }
}
