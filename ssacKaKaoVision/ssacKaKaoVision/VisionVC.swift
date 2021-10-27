//
//  VisionVC.swift
//  ssacKaKaoVision
//
//  Created by 강호성 on 2021/10/27.
//

import UIKit
//import YPImagePicker

class VisionVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var resultLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    // MARK: - Action
    
    @IBAction func requestButton(_ sender: UIButton) {
        VisionAPIManager.shared.fetchFaceData(image: postImageView.image!) { code, json in
            print(json)
            print("~~~ \(json["result"]["faces"])")
            
        }
    }
    
    @IBAction func changeImage(_ sender: UIButton) {
////        var config = YPImagePickerConfiguration()
////        config.screens = [.library]
//        
//        let picker = YPImagePicker()
//        picker.didFinishPicking { [unowned picker] items, _ in
//            if let photo = items.singlePhoto {
//                print(photo.fromCamera) // Image source (camera or library)
//                print(photo.image) // Final image selected by the user
//                print(photo.originalImage) // original image selected by the user, unfiltered
//                print(photo.modifiedImage) // Transformed image, can be nil
//                print(photo.exifMeta) // Print exif meta data of original image.
//            }
//            picker.dismiss(animated: true, completion: nil)
//        }
//        present(picker, animated: true, completion: nil)
//
//    }
    
}
