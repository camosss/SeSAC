//
//  DetailViewController.swift
//  ssacDramaInformation
//
//  Created by 강호성 on 2021/12/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    
    var id = 0
    var name = ""
    var season = [Season]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .black
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier:  UITableViewCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        configureTableView()
        populateData(id: id)
    }
    
    // MARK: - Action
    
    @objc func dismissDetailView() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Helper
    
    private func configureNavigationBar() {
        title = "영화 제목"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissDetailView))
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = 120
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
    }
    
    private func populateData(id: Int) {
        APIService().requestData(url: URL.detailURL(id: id)) { (result: Result<Seasons, APIError>)  in
            switch result {
            case .success(let response):
                print(response)
                DispatchQueue.main.async {
                    self.season = response.seasons ?? []
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.rawValue)
            }
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return season.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath) as! DetailTableViewCell
        cell.backgroundColor = .black
        cell.titleLabel.text = name
        
        let season = season[indexPath.row]
        cell.configureUI(season: season)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
