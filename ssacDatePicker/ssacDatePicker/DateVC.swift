//
//  DateVC.swift
//  ssacDatePicker
//
//  Created by 강호성 on 2021/10/07.
//

import UIKit

class DateVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var plus100Label: UILabel!
    @IBOutlet weak var plus200Label: UILabel!
    @IBOutlet weak var plus300Label: UILabel!
    @IBOutlet weak var plus400Label: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.preferredDatePickerStyle = .inline
    }
    
    // MARK: - Action
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        
        let value = format.string(from: sender.date)
        
        
        
        
        let afterDate = Date(timeInterval: 86400 * 100, since: sender.date)
        plus100Label.text = "\(afterDate)"
        
        let afterDate2 = Date(timeInterval: 86400 * 200, since: sender.date)
        plus200Label.text = "\(afterDate2)"
        
        let afterDate3 = Date(timeInterval: 86400 * 300, since: sender.date)
        plus300Label.text = "\(afterDate3)"
        
        let afterDate4 = Date(timeInterval: 86400 * 400, since: sender.date)
        plus400Label.text = "\(afterDate4)"
    }
    
}
