//
//  PersonViewController.swift
//  ssacAuth
//
//  Created by 강호성 on 2021/12/28.
//

import UIKit

class PersonViewController: UIViewController {
    
    // MARK: - Properties
    
    private let viewModel = PersonViewModel()
    
    fileprivate var tableView = UITableView()
    fileprivate var searchBar = UISearchBar()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        configureCustomSearchBar()
        setViewModel()
    }
    
    // MARK: - Helper
    
    private func setViewModel() {
        viewModel.person.bind { person in
            self.tableView.reloadData()
        }
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }

    private func configureCustomSearchBar() {
        let searchBar = UISearchBar()
        self.navigationController?.navigationBar.topItem?.titleView = searchBar

        searchBar.delegate = self
        searchBar.setImage(UIImage(named: "icSearchNonW"), for: UISearchBar.Icon.search, state: .normal)
        searchBar.setImage(UIImage(named: "icCancel"), for: .clear, state: .normal)

        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.leftView?.tintColor = .lightGray
        searchBar.searchTextField.rightView?.tintColor = .white
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension PersonViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemMint
        
        let data = viewModel.cellForRowAt(at: indexPath)
        cell.textLabel?.text = data.name
        
        return cell
    }
}

// MARK: - UISearchBarDelegate

extension PersonViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.populatePersonAPI(query: searchBar.text!, page: 1)
    }
}
