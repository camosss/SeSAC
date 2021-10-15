//
//  MemoVC.swift
//  ssacShoppingList
//
//  Created by 강호성 on 2021/10/14.
//

import UIKit

class MovieVC: UITableViewController {
    
    // MARK: - Properties
    
    let movieInfo = MovieInfo()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "영화"
    }
}

// MARK: - UITableViewDataSource

extension MovieVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfo.movie.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let info = movieInfo.movie[indexPath.row]
        
        cell.titleLabel.text = info.title
        cell.infoLabel.text = info.releaseDate
        cell.desLabel.text = info.overview
        cell.desLabel.numberOfLines = 0
        cell.postImageView.image = UIImage(named: info.title)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 6
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Movie", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailVC
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
