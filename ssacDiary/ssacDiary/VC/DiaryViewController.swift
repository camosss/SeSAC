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
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    let localRealm = try! Realm()
    let imagePicker = UIImagePickerController()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        handleDatePicker()
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
        guard let title = titleTextField.text else { return }
        guard let content = contentTextView.text else { return }
        guard let postImage = postImageView.image else { return }
        
        guard let registerDate = dateTextField.text, let register = DateFormatter.customFormat.date(from: registerDate) else { return }
        guard let customDate = dateButton.currentTitle, let custom = DateFormatter.customFormat.date(from: customDate) else { return }

        let task = UserDiary(diaryTitle: title, content: content, createdDate: register, registerDate: custom, postImage: "\(postImage)")
        
        try! localRealm.write {
            localRealm.add(task)
            saveImageToDocumentDirectory(imageName: "\(task._id).jpg", image: postImageView.image!)
            dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func addImageButton(_ sender: UIButton) {
        present(imagePicker, animated: true)
    }
    
    // datePicker - alert custom
    @IBAction func handleDateButton(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "날짜 선택", message: "날짜를 선택해주세요", preferredStyle: .alert)
        
        guard let contentView = self.storyboard?.instantiateViewController(withIdentifier: "DatePickerViewController") as? DatePickerViewController else { return }
        contentView.view.backgroundColor = .white
        contentView.preferredContentSize.height = 200
        
        alert.setValue(contentView, forKey: "contentViewController")
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "확인", style: .default) { _ in
            let value = DateFormatter.customFormat.string(from: contentView.datePicker.date)
            self.dateButton.setTitle(value, for: .normal)
        }
        
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        dateTextField.text = DateFormatter.customFormat.string(from: sender.date)
    }
    
    @objc func tapDone() {
        view.endEditing(true)
    }
    
    
    // MARK: - Helper
    
    func handleDatePicker() {
        let date = Date()
        dateTextField.text = DateFormatter.customFormat.string(from: date)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 200)
        dateTextField.inputView = datePicker
        
        configureToolBar()
    }
    
    func configureToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(tapDone))
        toolbar.setItems([doneBtn], animated: true)
        
        dateTextField.inputAccessoryView = toolbar
    }
    
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

// MARK: - UIImagePickerControllerDelegate

extension DiaryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 사진을 촬영하거나, 갤러리에서 사진을 선택한 직후에 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let value = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            postImageView.image = value
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

