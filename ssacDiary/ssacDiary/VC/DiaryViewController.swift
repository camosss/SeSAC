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
    @IBOutlet weak var contentTextView: UITextView!
    
    let localRealm = try! Realm()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        textViewPlaceHolder()
        
        title = LocalizableStrings.diary.localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont().mainDemiBold]

        titleTextField.placeholder = LocalizableStrings.title_text.localized
        contentTextView.text = LocalizableStrings.textView_text.localized
        navigationItem.rightBarButtonItem?.title = LocalizableStrings.save.localized
    }

    // MARK: - Action
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        print("save")
        guard let title = titleTextField.text else { return }
        guard let content = contentTextView.text else { return }
        
        let task = UserDiary(diaryTitle: title, content: content, createdDate: Date(), registerDate: Date())
        
        try! localRealm.write {
            localRealm.add(task)
        }
    }
    
    // MARK: - Helper
    
    func textViewPlaceHolder() {
        contentTextView.delegate = self
        contentTextView.text = "내용을 입력해주세요"
        contentTextView.textColor = UIColor.lightGray
    }
}

// MARK: - UITextViewDelegate

extension DiaryViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "내용을 입력해주세요"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            contentTextView.resignFirstResponder()
        }
        return true
    }
}
