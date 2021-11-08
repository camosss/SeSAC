//
//  AddMemoViewController.swift
//  ssacMemo
//
//  Created by 강호성 on 2021/11/08.
//

import UIKit

class AddMemoViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var contentView: UITextView!
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.becomeFirstResponder()
    }
    
    // MARK: - Action
    
    @IBAction func handleShareButton(_ sender: UIBarButtonItem) {
        print("share")
    }
    
    @IBAction func handleDoneButton(_ sender: UIBarButtonItem) {
        print("done")
    }
    
}
