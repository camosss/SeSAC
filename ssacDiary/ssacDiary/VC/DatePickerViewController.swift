//
//  DatePickerViewController.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/05.
//

import UIKit

class DatePickerViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var datePicker: UIDatePicker!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.preferredDatePickerStyle = .wheels
    }
}
