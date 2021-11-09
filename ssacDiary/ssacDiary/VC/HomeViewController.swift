//
//  HomeViewController.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    
    let array = [
        Array(repeating: "a", count: 5),
        Array(repeating: "b", count: 10),
        Array(repeating: "c", count: 10),
        Array(repeating: "d", count: 5),
        Array(repeating: "e", count: 15)
    ]
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        title = LocalizableStrings.home.localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont().mainDemiBold]

        tabBarController?.tabBar.items![0].title = LocalizableStrings.home.localized
        tabBarController?.tabBar.items![1].title = LocalizableStrings.search.localized
        tabBarController?.tabBar.items![2].title = LocalizableStrings.calendar.localized
        tabBarController?.tabBar.items![3].title = LocalizableStrings.setting.localized
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        
        cell.data = array[indexPath.row]
        cell.collectionView.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 300 : 170
    }
}


