//
//  SearchVC.swift
//  ssacTrendMedia
//
//  Created by 강호성 on 2021/10/17.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchVC: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private var boxOffice = [BoxOffice]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "박스오피스 순위"
        configureSearchBar()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let dateString = formatter.string(from: Date(timeIntervalSinceNow: -86400))
        fetchData(date: dateString)
    }
    
    // MARK: - Action
    
    @IBAction func exitButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper
    
    // search bar
    func configureSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "ex) 20210101 와 같이 날짜를 검색해주세요"
    }
    
    // MARK: - fetch Data
    
    func fetchData(date: String) {
        var tmp = [BoxOffice]()
        let appid = Bundle.main.apiKey
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(appid)&targetDt=\(date)"

        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    let rank = item["rank"].stringValue
                    let title = item["movieNm"].stringValue
                    let openDt = item["openDt"].stringValue
                    
                    let boxOffice = BoxOffice(rank: rank, title: title, openDt: openDt)
                    tmp.append(boxOffice)
                }
                
                DispatchQueue.main.async {
                    self.boxOffice = tmp
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boxOffice.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
        
        let boxOfficeValue = boxOffice[indexPath.row]
        cell.rankLabel.text = boxOfficeValue.rank
        cell.titleLabel.text = boxOfficeValue.title
        cell.dateLabel.text = boxOfficeValue.openDt
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 16
    }
}

// MARK: - UISearchResultsUpdating

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        fetchData(date: searchText)
    }
}
