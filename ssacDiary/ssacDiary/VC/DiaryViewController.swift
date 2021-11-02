//
//  DiaryViewController.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import UIKit
import RealmSwift

class DiaryViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selectDateButton: UIButton!
    @IBOutlet weak var ContentsTextView: UITextView!
    
    let localRealm = try! Realm()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizableStrings.diary.localized
    }

    // MARK: - Action
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        print("save")
        guard let title = titleTextField.text else { return }
        guard let content = ContentsTextView.text else { return }
        
        let task = UserDiary(diaryTitle: title, content: content, createdDate: Date(), registerDate: Date())
        
        try! localRealm.write {
            localRealm.add(task)
        }
    }
    
}
