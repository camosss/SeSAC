//
//  ShoppingVC.swift
//  ssacTableView
//
//  Created by 강호성 on 2021/10/13.
//

import UIKit

class ShoppingVC: UITableViewController {
    
    // MARK: - Propreties
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var shoppingList = ["그립톡 구매하기", "사이다 구매", "아이패드 케이스 최저가 알아보기", "양말"]
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Action
    
    @IBAction func addButton(_ sender: UIButton) {
        shoppingList.append(searchTextField.text!)
        tableView.reloadData()
        
        searchTextField.text = nil
    }
}

// MARK: - UITableViewDataSource

extension ShoppingVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingCell
        
        cell.listLabel.text = shoppingList[indexPath.row]
        cell.listLabel.font = UIFont.systemFont(ofSize: 15)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppingList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
