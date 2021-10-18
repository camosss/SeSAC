//
//  DetailVC.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/17.
//

import UIKit

class DetailVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var imageString = ""
    var titleString = ""
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "출연/제작"
        
        tableView.rowHeight = 100
        tableView.dataSource = self
        tableView.delegate = self
        
        configureHeaderView()
    }
    
    // MARK: - Helper
    
    func configureHeaderView() {
        titleLabel.text = titleString
        postImageView.setImage(imageUrl: imageString)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell
        
        cell.nameLabel.text = "이름"
        cell.roleLabel.text = "역할"
        cell.directorImageView.image = UIImage(named: "andrew")
        cell.directorImageView.layer.cornerRadius = 10
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
