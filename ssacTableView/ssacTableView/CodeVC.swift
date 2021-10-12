//
//  CodeVC.swift
//  ssacTableView
//
//  Created by 강호성 on 2021/10/12.
//

import UIKit

class CodeVC: UITableViewController {
    
    // MARK: - Properties
    
    var total: [String] = ["공지사항", "실험실", "버전 정보"]
    var personal: [String] = ["개인/보안", "알림", "채팅", "멀티프로필"]
    var etc: [String] = ["고객센터/도움말"]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableDataSource

extension CodeVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 { return "전체 설정" }
        else if section == 1 { return "개인 설정" }
        else if section == 2 { return "기타" }
        else { return "" }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 { return total.count }
        else if section == 1 { return personal.count }
        else if section == 2 { return etc.count }
        else { return 0 }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = total[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = personal[indexPath.row]
        } else if indexPath.section == 2 {
            cell.textLabel?.text = etc[indexPath.row]
        }
        
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
