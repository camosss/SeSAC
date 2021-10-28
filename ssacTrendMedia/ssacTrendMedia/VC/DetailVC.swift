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
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var backDropImageString = ""
    var titleString = ""
    var overViewString = ""
    var posterImageString = ""
            
    var expand = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "출연/제작"
        configureHeaderView()
    }
    
    // MARK: - Helper
    
    func configureHeaderView() {
        titleLabel.text = titleString
        
        let backDropImageUrl = "https://image.tmdb.org/t/p/original/\(backDropImageString)"
        backDropImageView.setImage(imageUrl: backDropImageUrl)
        
        let posterImageUrl = "https://image.tmdb.org/t/p/original/\(posterImageString)"
        posterImageView.setImage(imageUrl: posterImageUrl)
    }
    
    // MARK: - Action
    
    @objc func TapSeeMoreButton(button: UIButton) {
        expand = !expand
        tableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let summaryCell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as! SummaryCell
            summaryCell.summaryLabel.text = overViewString
            summaryCell.summaryLabel.numberOfLines = expand ? 0 : 2
            
            let img = expand ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            summaryCell.seeMoreButton.setImage(img, for: .normal)
            summaryCell.seeMoreButton.addTarget(self, action: #selector(TapSeeMoreButton(button:)), for: .touchUpInside)
            return summaryCell
        }
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return UITableView.automaticDimension
        }
        return UIScreen.main.bounds.height / 10
    }
}
