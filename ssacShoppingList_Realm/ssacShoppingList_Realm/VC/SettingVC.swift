//
//  SettingVC.swift
//  ssacShoppingList_Realm
//
//  Created by 강호성 on 2021/11/04.
//

import UIKit

class SettingVC: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Action
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SettingVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath) as! SettingCell
        
        guard let option = SettingOption(rawValue: indexPath.row) else { return cell }
        cell.titleLabel.text = option.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let row = indexPath.row
        
        if row == 0 { // 백업
            
        } else if row == 1 { // 복구
            
        }
    }
}
