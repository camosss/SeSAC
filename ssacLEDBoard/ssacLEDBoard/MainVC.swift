//
//  MainVC.swift
//  ssacLEDBoard
//
//  Created by 강호성 on 2021/10/01.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var inputText: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textColorButton: UIButton!
    @IBOutlet weak var boardText: UILabel!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    // MARK: - Helpers
    
    func configureUI() {
        
        view.backgroundColor = .black
        
        boardText.text = "텍스트를 입력해주세요"
        boardText.textColor = .white
        boardText.font = UIFont.boldSystemFont(ofSize: 70)
        
        setButton(button: sendButton, Text: "변경")
        setButton(button: textColorButton, Text: "Aa")
        textColorButton.setTitleColor(.red, for: .normal)
        
    }
    
    fileprivate func setButton(button: UIButton, Text: String) {
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.setTitle(Text, for: .normal)
        button.setTitleColor(.black, for: .normal)
    }
    
    func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    // MARK: - Action
    
    @IBAction func clickedTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func changeText(_ sender: UIButton) {
        boardText.text = inputText.text
    }
    
    @IBAction func changeTextColor(_ sender: Any) {
        boardText.textColor = randomColor()
        
    }
    
    
}
