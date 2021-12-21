//
//  DummyViewController.swift
//  ssacURLSession
//
//  Created by 강호성 on 2021/12/21.
//

import UIKit

class DummyViewController: UIViewController {
    
    // MARK: - Properties
    
    let viewModel = DummyViewModel()
        
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - Helper
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension DummyViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellforRowAt(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightOfRowAt
    }
}
