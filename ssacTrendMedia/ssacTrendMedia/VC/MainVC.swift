//
//  MainVC.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/15.
//

import UIKit
import Alamofire
import SwiftyJSON

class MainVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerIconView: UIView!
        
    private var media = [Media]() {
        didSet { tableView.reloadData() }
    }
    
    var page = 1
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeader()
        configureNavigation()
        fetchData()

        tableView.prefetchDataSource = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    // MARK: - Helper
    
    func configureHeader() {
        headerIconView.layer.cornerRadius = 10
        headerIconView.layer.shadowOpacity = 0.5
        headerIconView.layer.shadowRadius = 10
        headerIconView.layer.shadowOffset = .init(width: 0, height: -5)
        headerIconView.layer.shadowColor = UIColor.gray.cgColor
    }
    
    func configureNavigation() {
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "list.triangle"), style: .plain, target: self, action: #selector(tapMenu))
        let mapButton = UIBarButtonItem(image: UIImage(systemName: "map")!, style: .plain, target: self, action: #selector(tapMap))
        
        navigationItem.leftBarButtonItems = [menuButton, mapButton]
        navigationController?.navigationBar.tintColor = .black
    }

    // MARK: - Fetch Data
    
    func fetchData() {
        let appid = Bundle.main.tmDBApiKey
        let url = "https://api.themoviedb.org/3/trending/all/day?page=\(page)&api_key=\(appid)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                for item in json["results"].arrayValue {
                    
                    if item["media_type"].stringValue == "tv" {
                        let id = item["id"].intValue
                        let mediaType = item["media_type"].stringValue
                        let title = item["name"].stringValue
                        let voteAverage = item["vote_average"].stringValue
                        let releaseDate = item["first_air_date"].stringValue
                        let overView = item["overview"].stringValue
                        let posterImage = item["poster_path"].stringValue
                        let backDropImage = item["backdrop_path"].stringValue
                                                
                        self.media.append(Media(id: id, mediaType: mediaType, title: title, voteAverage: voteAverage, releaseDate: releaseDate, overView: overView, posterImage: posterImage, backDropImage: backDropImage))
                        
                    } else if item["media_type"].stringValue == "movie" {
                        let id = item["id"].intValue
                        let mediaType = item["media_type"].stringValue
                        let title = item["title"].stringValue
                        let voteAverage = item["vote_average"].stringValue
                        let releaseDate = item["release_date"].stringValue
                        let overView = item["overview"].stringValue
                        let posterImage = item["poster_path"].stringValue
                        let backDropImage = item["backdrop_path"].stringValue
                        
                        self.media.append(Media(id: id, mediaType: mediaType, title: title, voteAverage: voteAverage, releaseDate: releaseDate, overView: overView, posterImage: posterImage, backDropImage: backDropImage))
                    } else {
                        print("")
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }


    // MARK: - Action
    
    @objc func tapMenu() {
        print("Menu")
    }
    
    @objc func tapMap() {
        let sb = UIStoryboard(name: "Map", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MapVC") as! MapVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tapBook(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Book", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "BookVC") as! BookVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func tapLink(_ sender: UIButton) {
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        let cell = self.tableView.cellForRow(at: indexPath!) as! MainCell
        
        let sb = UIStoryboard(name: "Web", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebVC") as! WebVC
        vc.navigationTitle = cell.titleLabel.text ?? ""
        vc.id = media[indexPath?.row ?? 0].id
        vc.mediaType = media[indexPath?.row ?? 0].mediaType

        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        
        let media = media[indexPath.row]
        cell.typeLabel.text = "#\(media.mediaType)"
        cell.releaseDateLabel.text = media.releaseDate
        cell.titleLabel.text = media.title
        cell.voteLabel.text = media.voteAverage
        cell.overViewLabel.text = media.overView
        
        let imageUrl = "https://image.tmdb.org/t/p/original/\(media.backDropImage)"
        cell.backDropImageView.setImage(imageUrl: imageUrl)
        cell.backDropImageView.layer.cornerRadius = 10
        cell.backDropImageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
        cell.shadowView.layer.cornerRadius = 10
        cell.shadowView.layer.shadowOpacity = 0.5
        cell.shadowView.layer.shadowRadius = 10
        cell.shadowView.layer.shadowOffset = .init(width: 0, height: -5)
        cell.shadowView.layer.shadowColor = UIColor.lightGray.cgColor
        
        cell.linkButton.layer.cornerRadius = 40 / 2
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
        // 프로퍼티에 직접 접근해서 Data 전달
        let media = media[indexPath.row]
        vc.backDropImageString = media.backDropImage
        vc.posterImageString = media.posterImage
        vc.titleString = media.title
        vc.overViewString = media.overView
        vc.id = media.id
        vc.mediaType = media.mediaType
        
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 2
    }
}

// MARK: - UITableViewDataSourcePrefetching

extension MainVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
       //print(indexPaths)
        for indexPath in indexPaths {
            if media.count-1 == indexPath.row {
                page += 1
                fetchData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print(#function)
    }
}
