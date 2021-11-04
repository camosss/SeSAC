//
//  SettingVC.swift
//  ssacShoppingList_Realm
//
//  Created by 강호성 on 2021/11/04.
//

import UIKit
import Zip
import MobileCoreServices

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
    
    // MARK: - Helper(Backup)
    
    // 폴더 위치
    func documentDirectoryPath() -> String? {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        print("documentDirectory: \(documentDirectory), userDomainMask: \(userDomainMask)")
        
        if let directoryPath = path.first {
            return directoryPath
        } else {
            return nil
        }
    }
    
    func presentActivityViewController() {
        // 압축파일 경로
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    func handleBackup() {
        
        var urlPaths = [URL]() // 백업파일에 대한 URL 배열
        
        if let path = documentDirectoryPath() {
            
            // 백업 파일 URL
            // ex) Users/camosss/Library/Developer/.../Documents/default.realm
            let realm = (path as NSString).appendingPathComponent("default.realm")
            
            if FileManager.default.fileExists(atPath: realm) {
                urlPaths.append(URL(string: realm)!)
            } else {
                print("백업할 파일이 없습니다.")
            }
        }
        
        // urlPaths에 대한 압축파일 만들기
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive") // Zip
            print("압축 경로: \(zipFilePath)")
            presentActivityViewController()
        } catch {
            print("Something went wrong")
        }
    }
    
    // MARK: - Helper(Restore)
    
    func handleRestore() {
        // 파일앱 열기 + 확장자 (import MobileCoreServices)
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeArchive as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false // 둘 이상의 row 선택 여부
        self.present(documentPicker, animated: true, completion: nil)
    }
    
    func handleUnzipFile() throws {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentDirectory.appendingPathComponent("archive.zip")
        
        // destination: 위치, overwrite: 덮어쓰기, progress: 진행상황
        try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil, progress: { progress in
            print("progress: \(progress)")
            
            // 복구가 완료됨을 알림
            let alert = UIAlertController(title: "복구가 완료되었습니다!", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
            
        }, fileOutputHandler: { unzippedFile in
            print("unzippedFile \(unzippedFile)")
        })
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
        let row = indexPath.row
        
        if row == 0 { // 백업
            handleBackup()
        } else if row == 1 { // 복구
            handleRestore()
        }
    }
}

// MARK: - UIDocumentPickerDelegate

extension SettingVC: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        // 선택한 파일 경로
        guard let selectedFileURL = urls.first else { return }
        
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let sandboxFileURL = directory.appendingPathComponent(selectedFileURL.lastPathComponent) // selectedFileURL.lastPathComponent = default.realm
        
        // 압축 해제
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            
            do {
                try handleUnzipFile()
            } catch {
                print("unzip Error")
            }
        } else { // 파일앱의 zip -> document 폴더에 복사 (옮겨주기)
            
            do {
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                try handleUnzipFile()
            } catch {
                print("copy folder, unzip Error")
            }
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
}
