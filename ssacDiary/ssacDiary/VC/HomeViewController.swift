//
//  HomeViewController.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties

    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

//        firstLabel.font = UIFont().mainBold

        title = LocalizableStrings.home.localized
        
        tabBarController?.tabBar.items![0].title = LocalizableStrings.home.localized
        tabBarController?.tabBar.items![1].title = LocalizableStrings.search.localized
        tabBarController?.tabBar.items![2].title = LocalizableStrings.calendar.localized
        tabBarController?.tabBar.items![3].title = LocalizableStrings.setting.localized
    }
}
