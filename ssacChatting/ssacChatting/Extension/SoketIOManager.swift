//
//  SoketIOManager.swift
//  ssacChatting
//
//  Created by 강호성 on 2022/01/14.
//

import Foundation
import SocketIO

class SoketIOManager: NSObject {
    
    static let shared = SoketIOManager()

    let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxZTBjNjBiYmUzNDViZDllZDBjN2Q0OSIsImlhdCI6MTY0MjEyMDcxNSwiZXhwIjoxNjQyMjA3MTE1fQ.qqZ1ApNrUCsHV5fJz3X9i7ylKhctYe9_If3K9Pq0gLQ"
    
    // 서버와 메시지를 주고받기 위한 클래스
    var manager: SocketManager!
    
    // 클라이언트 소켓
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        
        let url = URL(string: "http://test.monocoding.com:1233")!
        // 소켓 통신 준비
        manager = SocketManager(socketURL: url, config: [
            .log(true),
            .compress,
            .extraHeaders(["auth" : token])
        ])
        
        socket = manager.defaultSocket // url 뒤에 "/"를 붙힌 룸
        
        // 소켓 연결 요청 메서드
        socket.on(clientEvent: .connect) { data, ack in
            print("socket Connected", data, ack)
        }

        // 소켓 연결 해제 메서드
        socket.on(clientEvent: .disconnect) { data, ack in
            print("socket DisConnected", data, ack)
        }
        
        // 소켓 채팅 듣는 메서드, sesac 이벤트로 날아온 데이터를 수신
        // 데이터 수신 -> 디코딩 -> 모델에 추가 -> 갱신
        socket.on("sesac") { dataArray, ack in
            print("sesac received", dataArray, ack)
            
            let data = dataArray[0] as! NSDictionary
            let chat = data["text"] as! String
            let name = data["name"] as! String
            let createdAt = data["createdAt"] as! String

            print("check", data, chat, name, createdAt)
            
            NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat" : chat, "name" : name, "createdAt" : createdAt])
        }
    }
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
}
