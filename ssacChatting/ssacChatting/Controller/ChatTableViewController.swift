//
//  ChatTableViewController.swift
//  ssacChatting
//
//  Created by 강호성 on 2022/01/14.
//

import UIKit
import Alamofire

class ChatTableViewController: UIViewController {
    
    // MARK: - Properties
    
    let name = "ian"
    
    let url = "http://test.monocoding.com:1233/chats"
    
    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNjBiYmUzNDViZDllZDBjN2Q0OSIsImlhdCI6MTY0MjEyMDcxNSwiZXhwIjoxNjQyMjA3MTE1fQ.qqZ1ApNrUCsHV5fJz3X9i7ylKhctYe9_If3K9Pq0gLQ"

    let tableView = UITableView()
    
    var list: [Chat] = []
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        requestChats()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getMessage(notification:)), name: NSNotification.Name("getMessage"), object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "보내기", style: .plain, target: self, action: #selector(barButtonClicked))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        SoketIOManager.shared.closeConnection()
    }
    
    // MARK: - Action
    
    @objc func getMessage(notification: NSNotification) {
        
        let chat = notification.userInfo!["chat"] as! String
        let name = notification.userInfo!["name"] as! String
        let createdAt = notification.userInfo!["createdAt"] as! String

        let value = Chat(text: "", userID: chat, name: "", username: name, id: "", createdAt: createdAt, updatedAt: "", v: 0, chatID: "")
        
        list.append(value)
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: self.list.count - 1, section: 0), at: .bottom, animated: false)
    }
    
    @objc func barButtonClicked() {
        postChat()
    }
    
    // MARK: - Helper
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "yourCell")
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        view.addSubview(tableView)
    }
    
    // DB(last chat time): 나중에는 DB에 기록된 채팅의 마지막 시간을 서버에 요청 (새로운 데이터만 서버에서 받아오기)
    func requestChats() {
        let header: HTTPHeaders = [
            "authorization": "Bearer \(token)",
            "accept": "application/json"
        ]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: [Chat].self) { response in
            switch response.result {
            case .success(let value):
                self.list = value
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: IndexPath(row: self.list.count - 1, section: 0), at: .bottom, animated: false)
                
                SoketIOManager.shared.establishConnection()
            case .failure(let error):
                print("Fail", error)
            }
        }
    }
    
    func postChat() {
        let header: HTTPHeaders = [
            "authorization": "Bearer \(token)",
            "accept": "application/json"
        ]
        
        let array = ["11111", "22222", "3333333"]
        
        AF.request(url, method: .post, parameters: ["text": "\(array.randomElement()!)"], encoder: JSONParameterEncoder.default, headers: header).responseString { response in
            print("Post Chat Success", response)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource 

extension ChatTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let data = list[indexPath.row]
        
        if data.name == name {
            let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
            cell.backgroundColor = .systemTeal
            
            var content = cell.defaultContentConfiguration()
            content.text = data.text
            content.image = UIImage(systemName: "person.fill")
            cell.contentConfiguration = content
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "yourCell")!
            cell.backgroundColor = .systemGray6
            
            var content = cell.defaultContentConfiguration()
            content.text = data.text
            content.image = UIImage(systemName: "person")
            cell.contentConfiguration = content
            return cell
        }
    }
}
