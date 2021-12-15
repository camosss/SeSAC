//
//  TabbarController.swift
//  ssacXib
//
//  Created by 강호성 on 2021/12/15.
//

import UIKit

class TabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let firstVC = templateNavigationController(image: UIImage(systemName: "star")!, rootViewController: ViewController())
        let secondVC = templateNavigationController(image: UIImage(systemName: "star")!, rootViewController: DetailViewController())
        let thirdVC = templateNavigationController(image: UIImage(systemName: "star")!, rootViewController: SettingViewController(nibName: "SettingViewController", bundle: nil))
        
//        setViewControllers([firstVC, secondVC, thirdVC], animated: true)
        viewControllers = [firstVC, secondVC, thirdVC]
        
        let appearence = UITabBarAppearance()
        appearence.configureWithDefaultBackground()
        
        tabBar.standardAppearance = appearence
        tabBar.scrollEdgeAppearance = appearence
        tabBar.tintColor = .black
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        print(item)
    }
    
    func templateNavigationController(image: UIImage, rootViewController: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
        nav.navigationBar.tintColor = .black
        return nav
    }
}
