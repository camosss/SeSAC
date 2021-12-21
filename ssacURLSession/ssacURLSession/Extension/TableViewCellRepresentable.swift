//
//  TableViewCellRepresentable.swift
//  ssacURLSession
//
//  Created by 강호성 on 2021/12/21.
//

import UIKit

protocol TableViewCellRepresentable {
    var numberOfSection: Int { get }
    var numberOfRowsInSection: Int { get }
    var heightOfRowAt: CGFloat { get }
    
    func cellforRowAt(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}
