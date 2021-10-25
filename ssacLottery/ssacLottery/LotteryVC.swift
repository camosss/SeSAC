//
//  LotteryVC.swift
//  ssacLottery
//
//  Created by 강호성 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class LotteryVC: UIViewController {
    
    // MARK: - Properties
        
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var threeLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    @IBOutlet weak var fiveLabel: UILabel!
    @IBOutlet weak var sixLabel: UILabel!
    @IBOutlet weak var sevenLabel: UILabel!
    
    @IBOutlet weak var roundPickerView: UIPickerView!
    
    let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNumLabel()
        configurePicker()
        getData(986)
    }
    
    // MARK: - Helper
    
    func configurePicker() {
        let pickerView = UIPickerView()
        searchTextField.inputView = pickerView
        pickerView.selectRow(99, inComponent: 0, animated: true)
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func makeRound(label: UILabel) {
        label.clipsToBounds = true
        label.layer.cornerRadius = 40/2
    }
    
    func configureNumLabel() {
        makeRound(label: oneLabel)
        makeRound(label: twoLabel)
        makeRound(label: threeLabel)
        makeRound(label: fourLabel)
        makeRound(label: fiveLabel)
        makeRound(label: sixLabel)
        makeRound(label: sevenLabel)
    }
    
    func background(label: UILabel, round: Int) {
        switch round {
        case 1...10: label.backgroundColor = .systemYellow
        case 11...20: label.backgroundColor = .systemBlue
        case 21...30: label.backgroundColor = .systemRed
        case 31...40: label.backgroundColor = .systemGray
        case 41...45: label.backgroundColor = .systemGreen
        default: label.backgroundColor = .white
        }
    }
    
    func roundLabel(_ json: JSON, data: String, label: UILabel) {
        label.text = "\(json[data])"
        self.background(label: label, round: json[data].intValue)
    }
    
    func getData(_ round: Int) {
        AF.request(url + "\(round)", method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.searchTextField.text = "\(round)"
                self.resultLabel.text = "\(round)회 당첨결과"
                
                self.roundLabel(json, data: "drwtNo1", label: self.oneLabel)
                self.roundLabel(json, data: "drwtNo2", label: self.twoLabel)
                self.roundLabel(json, data: "drwtNo3", label: self.threeLabel)
                self.roundLabel(json, data: "drwtNo4", label: self.fourLabel)
                self.roundLabel(json, data: "drwtNo5", label: self.fiveLabel)
                self.roundLabel(json, data: "drwtNo6", label: self.sixLabel)
                self.roundLabel(json, data: "bnusNo", label: self.sevenLabel)
                
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource

extension LotteryVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        100
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       // 986 - 99
        return "\(887 + row)"
    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getData(887 + row)
        searchTextField.endEditing(true)
    }
}
