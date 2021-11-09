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
    
//    let localRealm = try! Realm()
//    var tasks: Results<MemoList>!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.delegate = self
        
//        print(localRealm.configuration.fileURL!)
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
        
        // 리턴키를 입력하기 전까지 제목, 나머지는 내용
    
        
        
        guard let content = contentView.text else { return }
        
        let dateString = DateFormatter.totalFormatter.string(from: Date())
        guard let todayDate = DateFormatter.totalFormatter.date(from: dateString) else { return }
        
        print(content, todayDate)
        
//        let task = MemoList(title: <#T##String#>, subTitle: <#T##String#>, date: <#T##Date#>, fix: <#T##Bool#>)
        
//        try! localRealm.write {
//            localRealm.add(task)
//        }
        
        navigationController?.popViewController(animated: true) // 백버튼 액션도 추가 (메인뷰로 저장되면서 넘어가게)
    }
    
}

// MARK: - UITextViewDelegate

extension AddMemoViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            print(textView.text ?? "")
        }
        return true
    }
}
