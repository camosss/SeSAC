//
//  AsyncVC.swift
//  ssacVision
//
//  Created by 강호성 on 2021/10/29.
//

import UIKit

class AsyncVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    
    let url = "https://images.pexels.com/photos/2246476/pexels-photo-2246476.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Action
    
    @IBAction func requestButtonClicked(_ sender: UIButton) {
        
        DispatchQueue.global().async {
            if let url = URL(string: self.url), let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
}
