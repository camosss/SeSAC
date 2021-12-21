//
//  ViewController.swift
//  ssacURLSession
//
//  Created by 강호성 on 2021/12/21.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - Properties
    
    var apiService = APIService()
    var castData: Cast?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        populateData()
    }

    
    // MARK: - Helper
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }

    private func populateData() {
        apiService.requestCast { cast in
            self.castData = cast
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castData?.peopleListResult.peopleList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = castData?.peopleListResult.peopleList[indexPath.row].peopleNm
        return cell
    }
}
