//
//  MainVC.swift
//  ssacNewlyWord
//
//  Created by 강호성 on 2021/10/01.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var inputText: UITextField!

    @IBOutlet weak var hash1: UIButton!
    @IBOutlet weak var hash2: UIButton!
    
    let wordDictionary : [String : String] = ["삼귀자" : "연애를 시작하기 전 썸 단계!", "윰차" : "구독자 유무 차별", "실매" : "실시간 매니저", "꾸안꾸" : "꾸민 듯 안 꾸민 듯", "만반잘부" : "만나서 반가워 잘 부탁해"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboard()
        
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.tintColor = .black
        
        resultLabel.text = "신조어를 검색해보세요"
        
        setHashTag(hashButton: hash1, text: "꾸안꾸")
        setHashTag(hashButton: hash2, text: "만반잘부")
        
    }
    
    // MARK: - Helpers
    
    fileprivate func setHashTag(hashButton: UIButton, text: String) {
        hashButton.setTitle(text, for: .normal)
        hashButton.setTitleColor(.black, for: .normal)
        hashButton.layer.borderColor = UIColor.black.cgColor
        hashButton.layer.borderWidth = 1
        hashButton.layer.cornerRadius = 10
    }
    
    fileprivate func setAlert(message: String) {
        let alert = UIAlertController(title: "알림",
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - Action
    
    @IBAction func searchHashTag(_ sender: UIButton) {
        inputText.text = sender.currentTitle
        resultLabel.text = wordDictionary[inputText.text!]!
    }
        
    @IBAction func searchResult(_ sender: UIButton) {
        
        if wordDictionary[inputText.text!] == nil {
            setAlert(message: "해당하는 신조어를 찾을 수 없습니다.")
        } else {
            resultLabel.text = wordDictionary[inputText.text!]!
        }
    }
}
