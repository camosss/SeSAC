//
//  SettingViewController.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import UIKit
import Zip

/*
 백업하기
 - 사용자이 저장 공간 확인
    - 부족: 백업 불가
 - 백업 진행
    - 어떤 데이터도 없는 경우라면 백업할 데이터가 없다고 안내
    - realm, folder
    - Progress + UI 인터렉션 금지
 - zip
    - 백업 완료 시점에
    - Progress + UI 인터렉션 허용
 - 공유화면
 */

class SettingViewController: UIViewController {

    // MARK: - Properties

    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = LocalizableStrings.setting.localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont().mainDemiBold]

    }
    
    // MARK: - Helper
    
    // document 폴더 위치
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
        
        // 압축파일 경로 가져오기
        let fileName = (documentDirectoryPath()! as NSString).appendingPathComponent("archive.zip")
        let fileURL = URL(fileURLWithPath: fileName)
        
        let vc = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    // MARK: - Action
    
    @IBAction func testActivity(_ sender: UIButton) {
        presentActivityViewController()
    }
    
    
    @IBAction func tapBackupButton(_ sender: UIButton) {
        
        // 4. 백업할 파일에 대한 URL 배열
        var urlPaths = [URL]()
        
        // 1. document 폴더 위치
        if let path = documentDirectoryPath() {
            // 2. 백업하고자 하는 파일 URL 확인
            // 이미지 같은 경우, 백업 편의성을 위해 폴더를 생성하고, 폴더 내에 이미지를 저장하는 것이 효율적
            let realm = (path as NSString).appendingPathComponent("default.realm")
            
            // 3. 백업하고자 하는 파일 존재 여부 확인
            if FileManager.default.fileExists(atPath: realm) {
                // 5. URL 배열에 백업 파일 URL추가
                urlPaths.append(URL(string: realm)!)
            } else {
                print("백업할 파일이 없습니다")
            }
        }
        
        // 6. 4번 배열에 대해 압축 파일 만들기
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive") // Zip
            print("압축 경로: \(zipFilePath)")
            presentActivityViewController()
        } catch {
          print("Something went wrong")
        }
    }
    
}
