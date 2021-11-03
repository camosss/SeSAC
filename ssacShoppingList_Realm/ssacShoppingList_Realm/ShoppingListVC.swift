//
//  ShoppingListVC.swift
//  ssacShoppingList_Realm
//
//  Created by 강호성 on 2021/11/03.
//

import UIKit
import RealmSwift

class ShoppingListVC: UITableViewController {

    // MARK: - Properties
    
    @IBOutlet weak var searchTextField: UITextField!
    
    let localRealm = try! Realm()
    var tasks: Results<ShoppingList>!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(localRealm.configuration.fileURL!)
        tasks = localRealm.objects(ShoppingList.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    
    // MARK: - Action
    
    @IBAction func addButton(_ sender: UIButton) {
        guard let text = searchTextField.text else { return }
        
        if text.isEmpty {
            print("empty")
        } else {
            let task = ShoppingList(list: text)
            try! localRealm.write {
                localRealm.add(task)
            }
            tasks = localRealm.objects(ShoppingList.self)
            tableView.reloadData()
        }
        searchTextField.text = ""
    }
    
    @IBAction func filterButton(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for order in ShoppingListOptions.allCases {
            alert.addAction(UIAlertAction(title: order.description, style: .default, handler: { _ in
                print(order)
            }))
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ShoppingListVC {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingCell
        cell.delegate = self
        
        let row = tasks[indexPath.row]
        cell.listLabel.text = row.list
        cell.listLabel.numberOfLines = 0
        
        cell.checkButton.isSelected = row.check
        if row.check {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            cell.contentView.backgroundColor = .systemGreen.withAlphaComponent(0.5)
        } else {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            cell.contentView.backgroundColor = .white
        }
        
        cell.starButton.isSelected = row.star
        if row.star {
            cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let taskToDelete = tasks[indexPath.row]
            try! localRealm.write {
                localRealm.delete(taskToDelete)
            }
            tableView.reloadData()
        }
    }
}

// MARK: - ShoppingCellDelegate

extension ShoppingListVC: ShoppingCellDelegate {
    func isChecked(_ cell: ShoppingCell) {
        
        let buttonPosition = cell.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        
        let taskToUpdate = tasks[indexPath?.row ?? 0]
        
        try! localRealm.write {
            taskToUpdate.check.toggle()
            tableView.reloadData()
        }
    }
    
    func isStared(_ cell: ShoppingCell) {
        
        let buttonPosition = cell.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        
        let taskToUpdate = tasks[indexPath?.row ?? 0]
        
        try! localRealm.write {
            taskToUpdate.star.toggle()
            tableView.reloadData()
        }
    }
}
