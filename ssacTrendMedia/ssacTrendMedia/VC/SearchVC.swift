//
//  SearchVC.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/17.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let tvShowInfo = TvShowInfo()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tableView.rowHeight = 150
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Action
    
    @IBAction func exitButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowInfo.tvShow.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        
        let tvShow = tvShowInfo.tvShow[indexPath.row]
        cell.titleLabel.text = tvShow.title
        cell.releaseDateLabel.text = tvShow.releaseDate
        cell.overViewLabel.text = tvShow.overview
        cell.overViewLabel.numberOfLines = 0
        
        let url = URL(string: tvShow.backdropImage)
        do {
            let data = try Data(contentsOf: url!)
            cell.postImageView.image = UIImage(data: data)
            cell.postImageView.layer.cornerRadius = 10
        } catch {
            print("Upload Image Error!")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
