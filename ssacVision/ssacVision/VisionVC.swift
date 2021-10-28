//
//  VisionVC.swift
//  ssacVision
//
//  Created by 강호성 on 2021/10/27.
//

import UIKit
import JGProgressHUD

class VisionVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    let progress = JGProgressHUD()
    let imagePicker = UIImagePickerController()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = self
    }
    
    // MARK: - Action
    
    @IBAction func requestButton(_ sender: UIButton) {
        progress.show(in: view)
        VisionAPIManager.shared.fetchFaceData(image: postImageView.image!) { code, json in
            let jsonData = json["result"]["faces"][0]["facial_attributes"]
            let age = jsonData["age"].doubleValue
            self.ageLabel.text = "\(Int(age))세"
            
            let male = jsonData["gender"]["male"]
            let female = jsonData["gender"]["female"]
            if male > female { self.genderLabel.text = "남자" } else { self.genderLabel.text = "여자" }
            self.progress.dismiss()
        }
    }
    
    @IBAction func changeImage(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate

extension VisionVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // 사진을 촬영하거나, 갤러리에서 사진을 선택한 직후에 실행
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        
        if let value = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            postImageView.image = value
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
    }
}
