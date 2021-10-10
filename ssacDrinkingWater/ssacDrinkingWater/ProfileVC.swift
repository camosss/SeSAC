//
//  ProfileVC.swift
//  ssacDrinkingWater
//
//  Created by 강호성 on 2021/10/08.
//

import UIKit
import TextFieldEffects

class ProfileVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var heightTextField: HoshiTextField!
    @IBOutlet weak var weightTextField: HoshiTextField!
    
    let userDefaults = UserDefaults.standard

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = userDefaults.string(forKey: "name")
        nameTextField.text = name
        
        let height = userDefaults.double(forKey: "height")
        heightTextField.text = "\(height)"
        
        let weight = userDefaults.double(forKey: "weight")
        weightTextField.text = "\(weight)"
        
    }
    
    // MARK: - Helper
    
    fileprivate func saveStringData(tf: HoshiTextField, key: String) {
        userDefaults.set(tf.text, forKey: key)
        let update = userDefaults.string(forKey: key)
        tf.text = update
    }
    
    fileprivate func saveDoubleData(tf: HoshiTextField, key: String) {
        userDefaults.set(tf.text, forKey: key)
        let update = userDefaults.double(forKey: key)
        tf.text = "\(update)"
    }
    
    // MARK: - Action
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        if nameTextField.text!.isEmpty || heightTextField.text!.isEmpty || weightTextField.text!.isEmpty {
            let alert = UIAlertController(title: "알림",
                                          message: "정보를 정확히 기입해주세요",
                                          preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default)
            
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        } else {
            
            let alert2 = UIAlertController(title: "프로필 정보 저장", message: nil, preferredStyle: .alert)
            
            let OK = UIAlertAction(title: "OK", style: .default, handler: {_ in
                self.saveStringData(tf: self.nameTextField, key: "name")
                self.saveDoubleData(tf: self.heightTextField, key: "height")
                self.saveDoubleData(tf: self.weightTextField, key: "weight")
            })
            
            let NO = UIAlertAction(title: "NO", style: .destructive, handler: nil)
            
            alert2.addAction(OK)
            alert2.addAction(NO)
            
            present(alert2, animated: true, completion: nil)
        }
    }
    
}
