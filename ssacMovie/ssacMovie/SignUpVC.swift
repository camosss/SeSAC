//
//  SignUpVC.swift
//  ssacMovie
//
//  Created by 강호성 on 2021/09/30.
//

import UIKit

class SignUpVC: UIViewController {
    
    @IBOutlet weak var ID: UITextField!
    @IBOutlet weak var PW: UITextField!
    @IBOutlet weak var NICK: UITextField!
    @IBOutlet weak var LOCATION: UITextField!
    @IBOutlet weak var CODE: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var isSwitch: UISwitch!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpButton.layer.cornerRadius = 10
        signUpButton.clipsToBounds = true
        
    }
    
    // MARK: - Helpers
    
    fileprivate func setAlert(message: String) {
        let alert = UIAlertController(title: "알림",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Action
    
    @IBAction func tapClicked(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func signUP(_ sender: UIButton) {
        
        if ID.text!.isEmpty || PW.text!.isEmpty || PW.text!.count < 6 {
            setAlert(message: "ID 와 PW 를 정확히 입력해주세요. (PW 는 6자리 이상으로 입력해주세요)")
        } else if Int(CODE.text!) == nil {
            CODE.text = ""
            setAlert(message: "추천 코드는 숫자로만 입력해주세요.")
            
        } else {
            let resultText = """
                    회원가입 정보 확인
                    ID: \(ID.text!)
                    PW: \(PW.text!)
                    NICK: \(NICK.text!)
                    LOCATION: \(LOCATION.text!)
                    CODE: \(CODE.text!)
                    """
                    print(resultText)
        }
        
    }
    
    @IBAction func switchOnOff(_ sender: UISwitch) {
        
        if sender.isOn == false {
            NICK.isHidden = true
            LOCATION.isHidden = true
            CODE.isHidden = true
        } else if sender.isOn {
            NICK.isHidden = false
            LOCATION.isHidden = false
            CODE.isHidden = false
        }
    }
    
   
}
