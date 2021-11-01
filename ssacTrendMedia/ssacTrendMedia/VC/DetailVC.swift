//
//  DetailVC.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/17.
//

import UIKit
import Alamofire
import SwiftyJSON

class DetailVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var expand = false
    
    private var cast = [Cast]() {
        didSet { tableView.reloadData() }
    }
    
    private var crew = [Crew]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Received data

    var backDropImageString = ""
    var titleString = ""
    var overViewString = ""
    var posterImageString = ""
    var mediaType = ""
    var id = 0
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "출연/제작"
        tableView.dataSource = self
        tableView.delegate = self
        
        configureHeaderView()
        fetchData()
    }
    
    // MARK: - Helper
    
    func configureHeaderView() {
        titleLabel.text = titleString
        
        let backDropImageUrl = "https://image.tmdb.org/t/p/original/\(backDropImageString)"
        backDropImageView.setImage(imageUrl: backDropImageUrl)
        
        let posterImageUrl = "https://image.tmdb.org/t/p/original/\(posterImageString)"
        posterImageView.setImage(imageUrl: posterImageUrl)
    }
    
    // MARK: - Fetch Data
    
    func fetchData() {
        let appid = Bundle.main.tmDBApiKey
        var url = ""
        url = mediaType == "movie" ? "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=\(appid)&language=en-US" : "https://api.themoviedb.org/3/tv/\(id)/credits?api_key=\(appid)&language=en-US"
             
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                for cast in json["cast"].arrayValue {
                    let name = cast["name"].stringValue
                    let character = cast["character"].stringValue
                    let profileImage = cast["profile_path"].stringValue
                    
                    self.cast.append(Cast(name: name, character: character, profileImage: profileImage))
                }
                
                for crew in json["crew"].arrayValue {
                    let originalName = crew["original_name"].stringValue
                    let job = crew["job"].stringValue
                    let profileImage = crew["profile_path"].stringValue

                    self.crew.append(Crew(originalName: originalName, job: job, profileImage: profileImage))
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    // MARK: - Action
    
    @objc func TapSeeMoreButton(button: UIButton) {
        expand = !expand
        tableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DetailVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : section == 1 ? cast.count : crew.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "OverView" : section == 1 ? "Cast" : "Crew"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let summaryCell = tableView.dequeueReusableCell(withIdentifier: "SummaryCell", for: indexPath) as! SummaryCell
            summaryCell.summaryLabel.text = overViewString
            summaryCell.summaryLabel.numberOfLines = expand ? 0 : 2
            
            let img = expand ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
            summaryCell.seeMoreButton.setImage(img, for: .normal)
            summaryCell.seeMoreButton.addTarget(self, action: #selector(TapSeeMoreButton(button:)), for: .touchUpInside)
            return summaryCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath) as! DetailCell

            if indexPath.section == 1 {
                let cast = cast[indexPath.row]
                cell.titleLabel.text = cast.name
                cell.subTitleLabel.text = cast.character
                
                if cast.profileImage.isEmpty {
                    cell.profileImageView.backgroundColor = .lightGray
                } else {
                    let imageUrl = "https://image.tmdb.org/t/p/original/\(cast.profileImage)"
                    cell.profileImageView.setImage(imageUrl: imageUrl)
                }
                
            } else {
                let crew = crew[indexPath.row]
                cell.titleLabel.text = crew.originalName
                cell.subTitleLabel.text = crew.job
                
                if crew.profileImage.isEmpty {
                    cell.profileImageView.backgroundColor = .lightGray
                } else {
                    let imageUrl = "https://image.tmdb.org/t/p/original/\(crew.profileImage)"
                    cell.profileImageView.setImage(imageUrl: imageUrl)
                }
                
            }
            cell.profileImageView.layer.cornerRadius = 10
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        return UIScreen.main.bounds.height / 10
    }
}
