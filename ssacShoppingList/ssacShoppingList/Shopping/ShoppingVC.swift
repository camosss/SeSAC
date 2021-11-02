//
//  ShoppingVC.swift
//  ssacShoppingList
//
//  Created by 강호성 on 2021/10/14.
//

import UIKit
import RealmSwift

class ShoppingVC: UIViewController {
    
    // MARK: - Propreties
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!

    var shoppingList = [List]()
    
    //    let userDefaults = UserDefaults.standard
    let localRealm = try! Realm()
    var tasks: Results<ShoppingList>!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        print(localRealm.configuration.fileURL!)
        navigationItem.title = "쇼핑"

        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        
        tasks = localRealm.objects(ShoppingList.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Helper
    
    func saveData() {
//        let jsonEncoder = JSONEncoder()
//
//        if let saveData = try? jsonEncoder.encode(shoppingList) {
//            userDefaults.set(saveData, forKey: "List")
//        } else {
//            print("Failed to save data")
//        }
    }
    
    func loadData() {
//        let jsonDecoder = JSONDecoder()
//
//        if let loadData = userDefaults.object(forKey: "List") as? Data {
//            do {
//                shoppingList = try jsonDecoder.decode([List].self, from: loadData)
//            } catch {
//                print("Failed to load lists")
//            }
//        }
        
    }
    
    // MARK: - Action
    
    @IBAction func addButton(_ sender: UIButton) {
//        if !searchTextField.text!.isEmpty {
//            let list = List(list: searchTextField.text!, check: false, star: false)
//            shoppingList.append(list)
//            saveData()
//            tableView.reloadData()
//            searchTextField.text = nil
//        }
        
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
}

// MARK: - UITableViewDataSource


extension ShoppingVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingCell
        
//        cell.listLabel.text = shoppingList[indexPath.row].list
        
        let row = tasks[indexPath.row]
        cell.listLabel.text = row.list
        cell.starButton.isSelected = row.star
        cell.checkButton.isSelected = row.check
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
