//
//  DummyViewModel.swift
//  ssacURLSession
//
//  Created by 강호성 on 2021/12/21.
//

import UIKit

class DummyViewModel {
    var data: [String] = Array(repeating: "테스트", count: 100)
}

extension DummyViewModel: TableViewCellRepresentable {
    var numberOfSection: Int {
        return 1
    }
    
    var numberOfRowsInSection: Int {
        return data.count
    }
    
    var heightOfRowAt: CGFloat {
        return 60
    }
    
    func cellforRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
}
