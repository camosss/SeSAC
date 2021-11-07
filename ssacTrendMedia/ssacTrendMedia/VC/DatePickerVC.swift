//
//  DatePickerVC.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/11/07.
//

import UIKit

class DatePickerVC: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.preferredDatePickerStyle = .inline
    }
}
