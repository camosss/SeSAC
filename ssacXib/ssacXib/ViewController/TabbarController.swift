//
//  TabbarController.swift
//  ssacXib
//
//  Created by 강호성 on 2021/12/15.
//

import UIKit

class TabbarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarAppearence()
        
        let firstVC = templateNavigationController(image: UIImage(systemName: "star")!, rootViewController: ViewController())
        let secondVC = templateNavigationController(image: UIImage(systemName: "star.fill")!, rootViewController: DetailViewController())
        let thirdVC = templateNavigationController(image: UIImage(systemName: "person")!, rootViewController: SettingViewController(nibName: "SettingViewController", bundle: nil))
        
//        setViewControllers([firstVC, secondVC, thirdVC], animated: true)
        viewControllers = [firstVC, secondVC, thirdVC]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print(item)
    }
    
    // MARK: - Helper
    
    func templateNavigationController(image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.tintColor = .black
        return nav
    }
    
    func setTabBarAppearence() {
        let appearence = UITabBarAppearance()
        appearence.configureWithDefaultBackground()
        appearence.backgroundColor = .magenta
        
        tabBar.standardAppearance = appearence
        tabBar.scrollEdgeAppearance = appearence
        tabBar.tintColor = .black
    }
}
