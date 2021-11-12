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
    
    let localRealm = try! Realm()
    
    var tasks: Results<MemoList>! {
        didSet { tableView.reloadData() }
    }
    
    var filterTasks: Results<MemoList>! {
        didSet { tableView.reloadData() }
    }
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var inSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    let popUpService = PopUpService()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .systemOrange
        
        tableView.rowHeight = 60
        tableView.keyboardDismissMode = .onDrag
        
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTitle()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if !appDelegate.hasAlreadyLaunched {
            appDelegate.sethasAlreadyLaunched()
            displayPopUpView()
        }
    }

    // MARK: - Hepler
    
    func displayPopUpView(){
        let popUpVC = popUpService.popup()
        present(popUpVC, animated: true)
    }
    
    func configureTitle() {
        tasks = localRealm.objects(MemoList.self).sorted(byKeyPath: "date", ascending: false)

        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        let count = numberFormatter.string(from: NSNumber(value: tasks.count))!
        title = "\(count)개의 메모"
    }
    
    func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.becomeFirstResponder()
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
    override func numberOfSections(in tableView: UITableView) -> Int {
        return inSearchMode ? 1 : 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return inSearchMode ? "\(filterTasks.count)개 찾음" : section == 0 ? "고정된 메모" : (tasks.count == 0 ? "" : "메모")
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.textColor = .label
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        header.textLabel?.frame = header.bounds
        // UIVIew xib
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tasks.filter("fix == true").count == 0 {
            if section == 0 {
                return 0
            }
        }
        return 50
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filterTasks.count : section == 0 ? tasks.filter("fix == true").count : tasks.filter("fix == false").count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier, for: indexPath) as! MemoTableViewCell
        
        let row = inSearchMode ? filterTasks[indexPath.row] : indexPath.section == 0 ? tasks.filter("fix == true")[indexPath.row] : tasks.filter("fix == false")[indexPath.row]

        cell.titleLabel.text = row.title
        cell.subTitleLabel.text = row.subTitle
        
        let rowDate = DateFormatter.comparisonFormatter.string(from: row.date)
        let today = DateFormatter.comparisonFormatter.string(from: Date())
        
        var calendar = Calendar.autoupdatingCurrent
        calendar.firstWeekday = 1
        
        let startDate = calendar.startOfDay(for: row.date)
        var week = [String]()
        
        if let weekInterval = calendar.dateInterval(of: .weekOfYear, for: startDate) {
            for i in 0...6 {
                if let day = calendar.date(byAdding: .day, value: i, to: weekInterval.start) {
                    week += [DateFormatter.comparisonFormatter.string(from: day)]
                }
            }
        }
        
        
        if rowDate == today {
            cell.dateLabel.text = DateFormatter.todayFormatter.string(from: row.date)
        }
        else if week.contains(rowDate) {
            cell.dateLabel.text = DateFormatter.weekendFormatter.string(from: row.date)
        }
        else {
            cell.dateLabel.text = DateFormatter.totalFormatter.string(from: row.date)
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Add", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AddMemoViewController") as! AddMemoViewController
        vc.memolist = tasks[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - SwipeActionsConfiguration
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let fixStatus = tasks[indexPath.row].fix

        let fix = UIContextualAction(style: .normal, title: "Fix") { (action, view, nil) in
            
            if indexPath.section == 0 {
                try! self.localRealm.write {
                    self.tasks.filter("fix == true")[indexPath.row].fix.toggle()
                    tableView.reloadData()
                }
            } else {
                try! self.localRealm.write {
                    self.tasks.filter("fix == false")[indexPath.row].fix.toggle()
                    tableView.reloadData()
                }
            }
        }
        
        fix.image = fixStatus == true ? UIImage(systemName: "pin.slash.fill") : UIImage(systemName: "pin.fill")
        fix.backgroundColor = .systemOrange
        return UISwipeActionsConfiguration(actions: [fix])
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
            
            AlertHelper.okHandlerAlert(title: "삭제", message: "메모를 삭제하시겠습니까?", onConfirm: {
                let row = self.tasks[indexPath.row]

                try! self.localRealm.write {
                    self.localRealm.delete(row)
                    tableView.reloadData()
                    self.configureTitle()
                }
            }, over: self)
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

        filterTasks = localRealm.objects(MemoList.self).filter("title CONTAINS[c] '\(searchText)' OR subTitle CONTAINS[c] '\(searchText)'")
    }
}
