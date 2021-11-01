//
//  ViewController.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        firstLabel.text = LocalizableStrings.welcome_text.localized
        firstLabel.font = UIFont().mainBold
        
        secondLabel.text = LocalizableStrings.data_restore.localizedSetting
        
    }


}

