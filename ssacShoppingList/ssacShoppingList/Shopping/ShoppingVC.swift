//
//  ShoppingVC.swift
//  ssacShoppingList
//
//  Created by 강호성 on 2021/10/14.
//

import UIKit

class ShoppingVC: UITableViewController {
    
    // MARK: - Propreties
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var shoppingList = [List]()
    
    let userDefaults = UserDefaults.standard
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    // MARK: - Helper
    
    func saveData() {
        let jsonEncoder = JSONEncoder()
        
        if let saveData = try? jsonEncoder.encode(shoppingList) {
            userDefaults.set(saveData, forKey: "List")
        } else {
            print("Failed to save data")
        }
    }
    
    func loadData() {
        let jsonDecoder = JSONDecoder()
        
        if let loadData = userDefaults.object(forKey: "List") as? Data {
            do {
                shoppingList = try jsonDecoder.decode([List].self, from: loadData)
            } catch {
                print("Failed to load lists")
            }
        }
    }
    
    // MARK: - Action
    
    @IBAction func addButton(_ sender: UIButton) {
        if !searchTextField.text!.isEmpty {
            let list = List(list: searchTextField.text!)
            shoppingList.append(list)
            saveData()
            tableView.reloadData()
            searchTextField.text = nil
        }
    }
}

// MARK: - UITableViewDataSource


extension ShoppingVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingCell
        cell.listLabel.text = shoppingList[indexPath.row].list
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

