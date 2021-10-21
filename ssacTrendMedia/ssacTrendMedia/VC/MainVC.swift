//
//  MainVC.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/15.
//

import UIKit

class MainVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerIconView: UIView!
    
    let tvShowInfo = TvShowInfo()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHeader()
        configureNavigation()
        
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
        navigationItem.title = "TREND MEDIA"
        
        let menuButton = UIBarButtonItem(image: UIImage(systemName: "list.triangle"), style: .plain, target: self, action: #selector(tapMenu))
        let mapButton = UIBarButtonItem(image: UIImage(systemName: "map")!, style: .plain, target: self, action: #selector(tapMap))
        
        navigationItem.leftBarButtonItems = [menuButton, mapButton]
        navigationController?.navigationBar.tintColor = .black
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
        let indexPath = self.tableView.indexPathForRow(at:buttonPosition)
        let cell = self.tableView.cellForRow(at: indexPath!) as! MainCell
        
        let sb = UIStoryboard(name: "Web", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "WebVC") as! WebVC
        vc.navigationTitle = cell.titleLabel.text ?? ""

        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MainVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowInfo.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainCell
        
        let tvShow = tvShowInfo.tvShow[indexPath.row]
        
        cell.genreLabel.text = "#\(tvShow.genre)"
        cell.regionLabel.text = tvShow.region
        cell.rateLabel.text = "평점 \(tvShow.rate)"
        cell.titleLabel.text = tvShow.title
        cell.releaseDateLabel.text = tvShow.releaseDate
        cell.starringLabel.text = tvShow.starring
        
        cell.postImageView.setImage(imageUrl: tvShow.backdropImage)
        cell.postImageView.layer.cornerRadius = 10
        cell.postImageView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        
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
        let tvShow = tvShowInfo.tvShow[indexPath.row]
        vc.imageString = tvShow.backdropImage
        vc.titleString = tvShow.title
        vc.overViewString = tvShow.overview
        
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 1.9
    }
}