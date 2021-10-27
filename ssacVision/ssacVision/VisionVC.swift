//
//  VisionVC.swift
//  ssacVision
//
//  Created by 강호성 on 2021/10/27.
//

import UIKit

class VisionVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Action
    
    @IBAction func requestButton(_ sender: UIButton) {
        VisionAPIManager.shared.fetchFaceData(image: postImageView.image!) { code, json in
            let age = json["result"]["faces"][0]["facial_attributes"]["age"].doubleValue
            self.ageLabel.text = "\(Int(age))세"
            
            let male = json["result"]["faces"][0]["facial_attributes"]["gender"]["male"]
            let female = json["result"]["faces"][0]["facial_attributes"]["gender"]["female"]
            
            if male > female { self.genderLabel.text = "남자" } else { self.genderLabel.text = "여자" }
        }
    }
    
}
