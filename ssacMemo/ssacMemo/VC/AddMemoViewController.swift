//
//  AddMemoViewController.swift
//  ssacMemo
//
//  Created by 강호성 on 2021/11/08.
//

import UIKit
import RealmSwift

class AddMemoViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var contentView: UITextView!
    
    let localRealm = try! Realm()
    var tasks: Results<MemoList>!
    
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(localRealm.configuration.fileURL!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.becomeFirstResponder()
    }
    
    // MARK: - Helper
    
    func saveMemo() {
       if contentView.text.isEmpty {
           navigationController?.popViewController(animated: true)
       } else {
           let dateString = DateFormatter.totalFormatter.string(from: Date())
           guard let todayDate = DateFormatter.totalFormatter.date(from: dateString) else { return }
           
           if contentView.text.contains("\n") {
               var split = contentView.text.split(separator: "\n")
               let title = "\(split[0])"
               
               split.removeFirst()
               let context = split.joined(separator: "")
               
               let task = MemoList(title: title, subTitle: context, date: todayDate)
               try! localRealm.write {
                   localRealm.add(task)
               }
               
           } else {
               guard let title = contentView.text else { return }
               let context = "추가 텍스트 없음"
               
               let task = MemoList(title: title, subTitle: context, date: todayDate)
               try! localRealm.write {
                   localRealm.add(task)
               }
           }
           navigationController?.popViewController(animated: true)
       }
   }
    
    // MARK: - Action
    
    @IBAction func handleShareButton(_ sender: UIBarButtonItem) {
        print("share")
    }
    
    @IBAction func handleDoneButton(_ sender: UIBarButtonItem) {
        saveMemo()
    }
    
    @IBAction func handleBackButton(_ sender: UIBarButtonItem) {
        saveMemo()
    }
    
}
