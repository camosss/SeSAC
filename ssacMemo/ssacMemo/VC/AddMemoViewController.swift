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
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var shareBarButton: UIBarButtonItem!
    
    let localRealm = try! Realm()
    var tasks: Results<MemoList>!
    
    var memolist: MemoList!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.delegate = self
        BarButton.hideBarButton(shareBarButton, doneBarButton)
        setText()
        
//        print(localRealm.configuration.fileURL!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if memolist == nil {
            contentView.becomeFirstResponder()
        }
    }
    
    // MARK: - Helper
    
    func setText() {
        if memolist != nil {
            // 수정
            if memolist.subTitle == "추가 텍스트 없음" {
                contentView.text = memolist.title
            } else {
                contentView.text = "\(memolist.title)\n\(memolist.subTitle)"
            }
        }
    }
    
    func handleSaveAndEdit(title: String, context: String) {
        if memolist != nil {
            try! localRealm.write {
                memolist.title = title
                memolist.subTitle = context
            }
        } else {
            let task = MemoList(title: title, subTitle: context, date: Date())
            try! localRealm.write {
                localRealm.add(task)
            }
        }
    }
    
    func saveMemo() {
        if contentView.text.isEmpty {
            navigationController?.popViewController(animated: true)
        } else {
            if contentView.text.contains("\n") {
                var split = contentView.text.split(separator: "\n")
                let title = "\(split[0])"
                
                split.removeFirst()
                let context = split.joined(separator: "")
                
                handleSaveAndEdit(title: title, context: context)
                
            } else {
                guard let title = contentView.text else { return }
                let context = "추가 텍스트 없음"
                
                handleSaveAndEdit(title: title, context: context)
            }
            navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: - Action
    
    @IBAction func handleDoneButton(_ sender: UIBarButtonItem) {
        saveMemo()
    }
    
    @IBAction func handleBackButton(_ sender: UIBarButtonItem) {
        saveMemo()
    }
    
    @IBAction func handleShareButton(_ sender: UIBarButtonItem) {
        let activityController = UIActivityViewController(activityItems: [contentView.text ?? ""], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
}



// MARK: - UITextViewDelegate

extension AddMemoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        BarButton.showBarButton(shareBarButton, doneBarButton)
    }
}
