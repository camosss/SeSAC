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

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var selectDateButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    let localRealm = try! Realm()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        textViewPlaceHolder()
        print(localRealm.configuration.fileURL!)
        
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
            saveImageToDocumentDirectory(imageName: "\(task._id).jpg", image: postImageView.image!)
        }
    }
    
    // MARK: - Helper
    
    func textViewPlaceHolder() {
        contentTextView.delegate = self
        contentTextView.text = "내용을 입력해주세요"
        contentTextView.textColor = UIColor.lightGray
    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        
        // 1. 이미지 저장할 경로 설정: document 폴더
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        // 2. 이미지 파일 이름 설정, 최종 경로 설정 Desktop/.../222.png
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        // 3. 이미지 압축
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우 -> 덮어쓰기
            // 4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            
            // 4-2. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료!")
            } catch {
                print("이미지 삭제 실패..")
            }
        }
        
        // 5. 이미지를 document 폴더에 저장
        do {
            try data.write(to: imageURL)
            print("이미지 저장 완료!")
        } catch {
            print("이미지 저장 실패,,")
        }
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
