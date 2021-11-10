//
//  AddMemoViewController.swift
//  ssacMemo
//
//  Created by 강호성 on 2021/11/08.
//

import UIKit
import RealmSwift
import Zip

class AddMemoViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var contentView: UITextView!
    
    let localRealm = try! Realm()
    var tasks: Results<MemoList>!
    
    var memolist: MemoList!
        
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editMemo()
//        print(localRealm.configuration.fileURL!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        contentView.becomeFirstResponder()
    }
    
    // MARK: - Helper
    
    func editMemo() {
        if memolist != nil {
            print("수정")
        }
    }
    
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
    
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
    }
    
    func presentActivityViewController() {
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("Memo.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    
    // MARK: - Action
    
    @IBAction func handleDoneButton(_ sender: UIBarButtonItem) {
        saveMemo()
    }
    
    @IBAction func handleBackButton(_ sender: UIBarButtonItem) {
        saveMemo()
    }
 
    @IBAction func handleShareButton(_ sender: UIBarButtonItem) {

        var urlPaths = [URL]()
        
        if let path = documentDirectoryPath() {
            
            let realm = (path as NSString).appendingPathComponent("default.realm")
            
            if FileManager.default.fileExists(atPath: realm) {
                urlPaths.append(URL(string: realm)!)
            } else {
                print("백업할 파일이 없습니다")
            }
        }
        
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "Memo")
            print("압축 경로: \(zipFilePath)")
            presentActivityViewController()
        } catch {
          print("Something went wrong")
        }
    }
}
