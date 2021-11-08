//
//  MemoTableViewController.swift
//  ssacMemo
//
//  Created by 강호성 on 2021/11/08.
//

import UIKit
import RealmSwift
 
class MemoTableViewController: UITableViewController {

    // MARK: - Properties
    
    private let searchController = UISearchController(searchResultsController: nil)

//    let localRealm = try! Realm()
//    var tasks: Results<MemoList>!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80
        configureSearchController()
        navigationController?.navigationBar.tintColor = .systemOrange
//        print(localRealm.configuration.fileURL!)
//        tasks = localRealm.objects(MemoList.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Hepler
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.placeholder = "검색"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
    // MARK: - Action
    
    @IBAction func pushAddVC(_ sender: UIBarButtonItem) {
        let sb = UIStoryboard(name: "Add", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AddMemoViewController") as! AddMemoViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension MemoTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as! MemoTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let fix = UIContextualAction(style: .normal, title: "FIX") { (action, view, nil) in
            print("fix")
        }
        fix.backgroundColor = .systemOrange
        fix.image = UIImage(systemName: "pin.fill")
        return UISwipeActionsConfiguration(actions: [fix])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            print("delete")
        }
        delete.backgroundColor = .red
        delete.image = UIImage(systemName: "trash.fill")
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
}

// MARK: - UISearchResultsUpdating

extension MemoTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text?.lowercased() ?? ""
        print(searchText)
    }
}
