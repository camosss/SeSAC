//
//  DetailViewController.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/03.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var registerdDateLabel: UILabel!
    @IBOutlet weak var createdDateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    var diary: UserDiary!

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIData()
    }
    
    // MARK: - Helper
    
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        return nil
    }
    
    func configureUIData() {
        titleLabel.text = diary.diaryTitle
        contentLabel.text = diary.content
        registerdDateLabel.text = DateFormatter.customFormat.string(from: diary.registerDate)
        createdDateLabel.text = DateFormatter.customFormat.string(from: diary.createdDate)
        postImageView.image = loadImageFromDocumentDirectory(imageName: "\(diary._id).jpg")
    }
}
