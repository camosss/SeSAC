//
//  VC.swift
//  ssacShoppingList
//
//  Created by 강호성 on 2021/10/15.
//

import UIKit

class VC: UIViewController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Action
    
    @IBAction func movieButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "MovieVC") as! MovieVC
        let nav = UINavigationController(rootViewController: vc)
        present(nav, animated: true, completion: nil)
    }
    
    @IBAction func shoppingButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ShoppingVC") as! ShoppingVC
        navigationController?.pushViewController(vc, animated: true)
    }
}
