## 소켓 통신

<br>

- Server와 Client가 특정 포트를 통해 실시간으로 양방향 통신을 하는 방식.
- Client가 필요한 경우에만 요청을 보낼 수 있는 HTTP 통신과는 달리, Socket 통신은 Server 역시 Client로 요청을 보낼 수 있으며, 계속 연결을 유지하는 연결지향형 방식이기 때문에 실시간 통신이 필요한 경우에 자주 사용된다.

<br>

> Socket.io 설치링크 - [Socket.io-client-swift](https://github.com/socketio/socket.io-client-swift)
> 

<br>

## 소켓 클래스

<br>

- manager 변수를 생성하는 부분에서 서버의 url주소와 포트를 맞춰줘서 통신 준비.

```swift
// 서버와 메시지를 주고받기 위한 클래스
var manager: SocketManager!

let url = URL(string: "http://~~~.com:1233")!
// 소켓 통신 준비
manager = SocketManager(socketURL: url, config: [
     .log(true),
     .compress,
     .extraHeaders(["auth" : token])
 ])
```

<br>
<br>

- 소켓을 룸으로 나누어 룸(Namespace)단위로 구분할 수 있는 기능이 있다.

기존 url에 “/” 뒤에 룸(Namespace)명을 붙혀 구분이 가능하다. 

```swift
socket = manager.socket(forNamespace: "/ex")
```

<br>

여기서는 .defaultSocket을 사용하여 기본인 “/”의 위치에서 사용한다. 

```swift
socket = manager.defaultSocket
```

<br>
<br>

- 소켓(채팅) 듣는 메서드로 “sesac” 이벤트로 날아온 데이터를 수신한다.
- `NotificationCenter.default.post` 코드로 새로운 데이터를 수신할 때마다 등록된 observer에게 notification을 전달한다. (새로운 채팅을 바로바로 띄울 수 있게 처리)

```swift
socket.on("sesac") { dataArray, ack in
    print("sesac received", dataArray, ack)
            
    let data = dataArray[0] as! NSDictionary
    let chat = data["text"] as! String
    let name = data["name"] as! String
    let createdAt = data["createdAt"] as! String

    print("check", data, chat, name, createdAt)

    NotificationCenter.default.post(name: NSNotification.Name("getMessage"), object: self, userInfo: ["chat" : chat, "name" : name, "createdAt" : createdAt])
}
```

<br>
<br>

> Socket.IO 주요메서드
> 

<br>

1. **socket.connet**
    - 설정한 주소와 포트로 소켓 연결 시도
2. **socket.disconnet**
    - 소켓 연결 종료
3. **socket.emit("이벤트이름", ["데이터1", "데이터2"])**
    - 예시 ) socket.emit("ab", ["data1", "data2"])
    - "ab"란 이벤트이름으로 "data1","data2" 송신
4. **socket.on("이벤트이름")**
    - 예시 ) socket.on("abc")
    - 이름이 "abc"로 emit된 이벤트를 수신

<br>
<br>

## Controller

<br>

- 서버와의 데이터를 다룰 구조체 생성

```swift
struct Chat: Codable {
    let text, userID, name, username: String
    let id, createdAt, updatedAt: String
    let v: Int
    let chatID: String

    enum CodingKeys: String, CodingKey {
        case text
        case userID = "userId"
        case name, username
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
        case chatID = "id"
    }
}
```

<br>
<br>

### 📡  수신


- 서버로부터 온 소켓 데이터 수신

**데이터 수신 → 디코딩 → 모델에 추가 → 갱신**

`SoketIOManager.shared.establishConnection()` → 설정한 주소와 포트로 소켓 연결 시도

```swift
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
```

<br>
<br>

- 채팅 기능이기 때문에, 행을 추가할 때 제일 아래에 추가해야해서 구조체배열에 있는 마지막행에 추가를 하면되므로, `self.list.count - 1` 를 해준다.
- 새로운 채팅이 오면 자동으로 밑(.bottom)으로 내려가도록 `scrollToRow`을 이용해서 마지막행으로 스크롤되도록 설정해준다.

```swift
self.tableView.scrollToRow(at: IndexPath(row: self.list.count - 1, section: 0), at: .bottom, animated: false)
```

<br>
<br>

- 또한 소켓 클래스에서 `NotificationCenter` 를 통해 전달받은 observer를 처리 (addObserver(관찰자를 대기시킴)) 함으로써, 새로운 채팅 데이터를 View에 계속해서 띄운다.

```swift
var list: [Chat] = []

NotificationCenter.default.addObserver(self, 
                                       selector: #selector(getMessage(notification:)), 
                                       name: NSNotification.Name("getMessage"),
                                       object: nil)

...

@objc func getMessage(notification: NSNotification) {
    let chat = notification.userInfo!["chat"] as! String
    let name = notification.userInfo!["name"] as! String
    let createdAt = notification.userInfo!["createdAt"] as! String

    let value = Chat(text: "", userID: chat, name: "", username: name, id: "", createdAt: createdAt, updatedAt: "", v: 0, chatID: "")
        
    list.append(value)
    tableView.reloadData()
    tableView.scrollToRow(at: IndexPath(row: self.list.count - 1, section: 0), at: .bottom, animated: false)
}
```

<br>
<br>

### 📡  송신


- 채팅 송신

여기서는 채팅 text를 보낼 TextField를 만들지 않았기 때문에, 임시로 배열에 text를 넣어 랜덤으로 발송한다.

```swift
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
```

<br>
<br>

> 임시로 Cell을 2개로 나눠 받아오는 데이터의 이름과 비교하여 내가 보낸 채팅과 상대방이 보낸 채팅을 구분해주었다.

<img src = "https://user-images.githubusercontent.com/93528918/149484324-1894c77e-223e-49ed-8c58-7f01e26e6f0d.png" width="30%" height="30%">
