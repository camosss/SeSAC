//
//  SettingViewController.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import UIKit

class SettingViewController: UIViewController {

    // MARK: - Properties

    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizableStrings.setting.localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont().mainDemiBold]

    }
}
