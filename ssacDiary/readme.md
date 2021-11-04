
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


---

## 4️⃣  백업, 복구

### ✔️ 백업

1. 데이터가 저장된 document 위치 찾기

```swift
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
```

2. 백업할 파일 주소(**/default.realm**)를 추가하고, 파일 존재 여부를 확인한 뒤에 URL배열 (백업할 파일에 대한 URL배열) 에 추가한다.

```swift
Users/camosss/Library/Developer/ ... /Documents/default.realm
```

3. 압축 진행
- `Zip` 프레임워크를 사용해서 백업할 파일 압축을 진행한다.
- `UIActivityViewController`를 통해 백업을 완료한 파일을 공유할 수 있다!

```swift
do {
    // 압축 경로
    let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "archive") // Zip
    presentActivityViewController()
} catch {
     print("Something went wrong")
}
```

![스크린샷 2021-11-04 오후 7 29 45](https://user-images.githubusercontent.com/93528918/140302351-101359ac-b60f-4fd4-b03b-12f1980fd61d.png)



---

### ✔️ 복구

- 아이폰의 `파일` 앱을 가져오기 위해 `MobileCoreServices` 임포트
- `UIDocumentPickerViewController`를 delegate로 연결한다.
- 선택한 파일의 경로를 가져와서 압축 해제 (이 과정 또한 파일의 존재 여부를 확인한다.)
- `Zip` 프레임워크의 압축해제 코드

**destination: 위치, overwrite: 덮어쓰기, progress: 진행상황**

```swift
try Zip.unzipFile(fileURL, destination: documentDirectory, overwrite: true, password: nil,
    progress: { progress in
        // 복구가 완료됨을 알림
    }, fileOutputHandler: { unzippedFile in
        print("unzippedFile \(unzippedFile)")
    })
```

- 파일이 해당 document에 저장되어있지 않다면, document 폴더에 옮겨준다.

```swift
try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
```



---

cf. **SandBox**

> SandBox란 커널 수준에서 강제 적용되는 맥 OS의 접근 제어 기술이다.
> 사용자의 파일앱에 저장하는 방법을 알기전에, 샌드박싱의 개념을 알고가야 한다.

예를 들어, 하나의 폰에서 실행중인 두개의 앱을 실행중이다. 그런데, 하나의 앱에 악성 소프트웨어가 있는데 같은 폰에 있는 다른 앱을 감염시키려 한다. iOS에서는 이 문제를 샌드박싱으로 해결한다.

폰의 모든 앱이 자체 샌드박스 안에 있다고 해보자. 샌드박스는 보호된 환경 그 이상도 아니다. 또는 앱을 위한 작은 감옥으로 생각할 수도 있다.

각 앱에는 앱과 관련된 파일 및 문서를 저장하는 자체 폴더가 있다. 따라서 앱이 데이터를 저장하거나 검색해야 할 때 데이터를 읽고 쓸 수 있다. 해당 문서 폴더에 액세스할 수 있지만, 다른 앱 문서 폴더에 엑세스할 수는 없다.

대신 폰이 iCloud와 동기화되거나 laptop에 연결할 때마다 발생한다. 예를 들어, 폰을 새로 구입하는 경우 iCloud 또는 iTunes와 지속적으로 동기화되기 때문에 문서 폴더에 저장한 모든 데이터는 삭제되지 않는다.

또한, 앱 자체가 운영 체제의 코드에 영향을 줄 수 있음을 의미하기에, 운영 체제에서 보안 데이터를 가져오기 위해악성 앱을 작성할 수 없다. 예를 들어, 테이블쪽으로 폰을 놓으면 방해금지모드로 전환되는 앱, iOS에서는 이것을 구현할 방법이 없다.




