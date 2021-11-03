
## 1️⃣ 다국어 지원 

![스크린샷 2021-11-02 오후 6 22 46](https://user-images.githubusercontent.com/93528918/139820369-038475c9-a2e9-4e7b-aebf-e200c96f89e0.png)


```swift
enum LocalizableStrings: String {
    case home
    case search
    case calendar
    case setting
    case diary
    case title_text
    case date_text
    case textView_text
    case save
    
    var localized: String {
        return self.rawValue.localized() // default - Localizable.strings
    }
}
```

- TabBar **처음 로딩되는 ViewController**인 HomeViewController에서 구현 

```swift
HomeViewController

override func viewDidLoad() {
    ...
    
    tabBarController?.tabBar.items![0].title = LocalizableStrings.home.localized
    tabBarController?.tabBar.items![1].title = LocalizableStrings.search.localized
    tabBarController?.tabBar.items![2].title = LocalizableStrings.calendar.localized
    tabBarController?.tabBar.items![3].title = LocalizableStrings.setting.localized
}
```

- Navigation Title 
개별 ViewController에서 구현 (+ 폰트) 

```swift
HomeViewController
title = LocalizableStrings.home.localized
navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont().mainDemiBold]

SearchViewController
title = LocalizableStrings.search.localized
navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont().mainDemiBold]

...
```


***한국어***

<img src = "https://user-images.githubusercontent.com/93528918/139818762-b4f65961-0f21-482f-bd59-e774faf1d459.png" width="25%" height="25%"><img src = "https://user-images.githubusercontent.com/93528918/139818770-c5c6cc11-2d11-44f8-bb3b-1ed9fd9c0292.png" width="25%" height="25%">


***일본어***

<img src = "https://user-images.githubusercontent.com/93528918/139818786-1c76e721-5ebf-454c-9734-b57eaaba4f9f.png" width="25%" height="25%"><img src = "https://user-images.githubusercontent.com/93528918/139818795-cb334076-8687-47ed-bc8a-412bf71e1541.png" width="25%" height="25%">


***영어***

<img src = "https://user-images.githubusercontent.com/93528918/139818800-9187c76e-6e2b-4a3e-832f-d2903f7ec908.png" width="25%" height="25%"><img src = "https://user-images.githubusercontent.com/93528918/139818811-c038ce80-a7e0-4410-9646-cc551ce1a19b.png" width="25%" height="25%">


---

## 2️⃣ Image

### 이미지 저장

1. 이미지 저장할 경로 설정: document 폴더
2. 이미지 파일 이름 설정, 최종 경로 설정 ex) Desktop/.../222.png
3. 이미지 압축
4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우 -> 덮어쓰기
    - 이미지 경로 여부 확인
    - 기존 경로에 있는 이미지 삭제
5. 이미지를 document 폴더에 저장

```swift
func saveImageToDocumentDirectory(imageName: String, image: UIImage) {    
    // 1.
    guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

    // 2.
    let imageURL = documentDirectory.appendingPathComponent(imageName)
        
    // 3.
    guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
    // 4.
        // 4-1.
    if FileManager.default.fileExists(atPath: imageURL.path) {
            
        // 4-2.
        do {
            try FileManager.default.removeItem(at: imageURL)
            print("이미지 삭제 완료!")
        } catch {
            print("이미지 삭제 실패..")
        }
    }
        
    // 5.
    do {
        try data.write(to: imageURL)
        print("이미지 저장 완료!")
    } catch {
        print("이미지 저장 실패,,")
    }
}
```

### 이미지 불러오기

***document 폴더 경로 -> 이미지 찾기 -> UIImage -> UIImageView***

```swift
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

...

cell.postImageView.image = loadImageFromDocumentDirectory(imageName: "\(row._id).jpg")
```

### 이미지 삭제

1. 이미지 저장할 경로 설정: document 폴더
2. 이미지 파일 이름 설정, 최종 경로 설정 ex) Desktop/.../222.png
3. 이미지 경로 여부 확인
4. 기존 경로에 있는 이미지 삭제

```swift
func deleteImageFromDocumentDirectory(imageName: String) {
        
    // 1.
    guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

    // 2.
    let imageURL = documentDirectory.appendingPathComponent(imageName)
        
    // 3.
    if FileManager.default.fileExists(atPath: imageURL.path) {
        // 4.
        do {
            try FileManager.default.removeItem(at: imageURL)
            print("이미지 삭제 완료!")
        } catch {
            print("이미지 삭제 실패..")
        }
    }
}
```

***스와이프로 해당 Cell을 삭제할 때, 이미지를 저장한 폴더에서 먼저 삭제하고 Realm에서 데이터를 삭제한다.***

‼️ 반대로하면 Index 꼬임

```swift
func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    let row = tasks[indexPath.row]

    try! localRealm.write {
     1. deleteImageFromDocumentDirectory(imageName: "\(row._id).jpg")
     2. localRealm.delete(row)
        tableView.reloadData()
    }
}
```



---

## 3️⃣ UIDatePicker, UIImagePicker


https://user-images.githubusercontent.com/74236080/140070505-2bc01416-c36d-4a90-bb97-9fe89f67552c.mov






