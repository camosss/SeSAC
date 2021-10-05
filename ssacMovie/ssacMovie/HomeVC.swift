//
//  HomeVC.swift
//  ssacMovie
//
//  Created by 강호성 on 2021/09/29.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var mainView: UIImageView!
    @IBOutlet weak var preview1: UIImageView!
    @IBOutlet weak var preview2: UIImageView!
    @IBOutlet weak var preview3: UIImageView!
    
    @IBOutlet weak var previewLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        mainView.image = UIImage(named: "poster\(Int.random(in: 1...20))")

        previewLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        bottomImage(previewName: preview1)
        bottomImage(previewName: preview2)
        bottomImage(previewName: preview3)

    }
    
    // MARK: - Helpers
    
    fileprivate func bottomImage(previewName: UIImageView) {
        previewName.image = UIImage(named: "poster\(Int.random(in: 1...20))")
        previewName.layer.cornerRadius = 120 / 2
        previewName.clipsToBounds = true
        previewName.layer.borderWidth = 2
        previewName.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    @IBAction func playButton(_ sender: UIButton) {
        
        let num = Int.random(in: 1...20)
        let imageName = UIImage(named: "poster\(num)")
        mainView.image = imageName
        
        let one = Int.random(in: 1...20)
        let preview1Name = UIImage(named: "poster\(one)")
        preview1.image = preview1Name
        
        let two = Int.random(in: 1...20)
        let preview2Name = UIImage(named: "poster\(two)")
        preview2.image = preview2Name
        
        let third = Int.random(in: 1...20)
        let preview3Name = UIImage(named: "poster\(third)")
        preview3.image = preview3Name
    }
}
