//
//  SearchViewController.swift
//  ssacDiary
//
//  Created by 강호성 on 2021/11/01.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        title = LocalizableStrings.search.localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont().mainDemiBold]

        tasks = localRealm.objects(UserDiary.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Helper
    
    // document 폴더 경로 -> 이미지 찾기 -> UIImage -> UIImageView
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        return nil
    }
    
    func deleteImageFromDocumentDirectory(imageName: String) {
        
        // 1. 이미지 저장할 경로 설정: document 폴더
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        // 2. 이미지 파일 이름 설정, 최종 경로 설정 Desktop/.../222.png
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        // 3. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            
            // 4. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료!")
            } catch {
                print("이미지 삭제 실패..")
            }
        }
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchCell.identifier, for: indexPath) as! SearchCell
        
        let row = tasks[indexPath.row]
        cell.titleLabel.text = row.diaryTitle
        cell.contentLabel.text = row.content
        cell.postImageView.image = loadImageFromDocumentDirectory(imageName: "\(row._id).jpg")
        cell.dateLabel.text = DateFormatter.customFormat.string(from: row.registerDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Detail", bundle: Bundle.main)
        let vc = sb.instantiateViewController(withIdentifier: "Detail") as! DetailViewController
        
        navigationController?.pushViewController(vc, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)

        
//        let taskToUpdate = tasks[indexPath.row]
        // 1. 수정 - 레코드에 대한 값 수정
//        try! localRealm.write {
//            taskToUpdate.diaryTitle = "제목 수정"
//            taskToUpdate.content = "내용 수정"
//            tableView.reloadData()
//        }
        
        // 2. 일괄 수정
        /*
        try! localRealm.write {
            tasks.setValue(Date(), forKey: "createdDate")
            tasks.setValue("일괄 수정", forKey: "diaryTitle")
            tableView.reloadData()
        }*/
        
        // 3. 수정: primary key 기준으로 수정할 때 사용 (권장x)
        // value에 작성한 내용빼고 다 삭제된다
        /*
        try! localRealm.write {
            let update = UserDiary(value: ["_id": taskToUpdate._id, "diaryTitle": "이것만 바꾸기"])
            localRealm.add(update, update: .modified)
            tableView.reloadData()
        }*/
        
        // 4. value에 작성한 내용만 변경되고 나머지는 그대로
        /*
        try! localRealm.write {
            localRealm.create(UserDiary.self, value: ["_id": taskToUpdate._id, "diaryTitle": "이것만 변경"], update: .modified)
            tableView.reloadData()
        }*/
    }
    
    // Swipe to delete (canEditRowAt, commit editingStyle)
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let row = tasks[indexPath.row]

        try! localRealm.write {
            deleteImageFromDocumentDirectory(imageName: "\(row._id).jpg")
            localRealm.delete(row)
            tableView.reloadData()
        }
    }
}
