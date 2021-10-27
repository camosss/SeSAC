## #1 화면 전환

https://user-images.githubusercontent.com/74236080/137635789-57feeb91-b8ac-4813-9ab0-74acaeef4b50.mov

---

## #2 데이터 전달

1번 View (MainVC)에서 해당 TableCell 을 선택했을 때, 데이터를 전달하고 1번 View (MainVC)에서 받은 데이터를 통해 2번 View (DetailVC)를 그린다.

<img src = "https://user-images.githubusercontent.com/74236080/137711980-1363c9aa-29d3-4f81-8640-9158ed0c6a62.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/137712063-c32bf4fb-2f73-46e4-b2eb-8cec769979f1.png" width="30%" height="30%">


---

### 프로퍼티에 직접 접근해서 Data 전달

1. 2번(DetailVC)에서 데이터를 전달받을 프로퍼티를 생성한다.

***DetailVC***
![스크린샷 2021-10-18 오후 7 14 02](https://user-images.githubusercontent.com/74236080/137712368-5d14e20d-f3d9-4ff0-b13e-c670194e2bd4.png)

2. 1번(MainVC)에서 "DetailVC" identifier을 가지고 있는 ViewController(DetailVC)를 선언하고, 2번(DetailVC)에 있는 전달받을 프로퍼티에 접근해서 전달할 데이터를 넣어준다.

***MainVC***
![스크린샷 2021-10-18 오후 7 14 31](https://user-images.githubusercontent.com/74236080/137712570-dc75c54b-e254-4c4d-9423-e2d345ce51e0.png)


3. 데이터를 전달받은 2번(DetailVC)으로 와서 데이터를 대입한다.

***DetailVC***
![스크린샷 2021-10-18 오후 7 14 50](https://user-images.githubusercontent.com/74236080/137712594-99684b2d-4170-43d4-9186-6db946e6120b.png)



https://user-images.githubusercontent.com/74236080/137712785-64ffa589-2b84-4012-8756-1ae278a75a60.mov


---

### 링크 버튼을 클릭하면 WebVC로 화면 전환

화면 전환 시 타이틀 값을 전달하고, 전달한 값을 네비게이션 타이틀 넣기

```swift
@IBAction func tapLink(_ sender: UIButton) {
    
    // cell의 indexPath
    let buttonPosition = sender.convert(CGPoint.zero, to: self.tableView)
    let indexPath = self.tableView.indexPathForRow(at:buttonPosition)
    let cell = self.tableView.cellForRow(at: indexPath!) as! MainCell
       
    let sb = UIStoryboard(name: "Web", bundle: nil)
    let vc = sb.instantiateViewController(withIdentifier: "WebVC") as! WebVC
    vc.navigationTitle = cell.titleLabel.text ?? ""

    let nav = UINavigationController(rootViewController: vc)
    self.present(nav, animated: true, completion: nil)
}
```

- 링크 버튼에 액션을 줬을 때, 해당 cell 의 데이터를 가져오기 위해 MainCell의 **indexPath** 값을 가져온다.
- WebVC인 vc에 데이터를 전달받을 프로퍼티를 생성해서 해당 cell의 title값을 넣어준다.

[셀에서 버튼을 클릭하면 UITableViewCell의 indexPath 가져오기](https://newbedev.com/get-indexpath-of-uitableviewcell-on-click-of-button-from-cell)


https://user-images.githubusercontent.com/74236080/137712744-7103028c-b96d-45e9-8de0-2ac9a54b8299.mov

---

### Kingfisher 라이브러리

파일을 새로 생성해서, 이미지를 설정할 imageView에 메소드체이닝으로 KingFisher를 호출하여 setImage() 메소드를 이용한다.

아래와 같이 코드를 작성하면 KingFisher가 url로 부터 이미지를 다운받고, 이를 메모리와 디스크 캐시에 저장한다. 그 후 imageView에 띄운다.

**첫 다운로드 때 이를 캐시에 저장**해놓기 때문에 추후 같은 URL에 대한 이미지 요청시 캐시로부터 데이터를 바로 가져오기 때문에, 빠른 속도로 처리가 가능하다.

```swift
import UIKit
import Kingfisher

extension UIImageView {
    func setImage(imageUrl: String) {
        self.kf.setImage(with: URL(string: imageUrl))
    }
}
```

***url String을 Kingfisher 라이브러리 사용 ❌***

```swift
let url = URL(string: tvShow.backdropImage)
do {
    let data = try Data(contentsOf: url!)
    cell.postImageView.image = UIImage(data: data)
} catch {
     print("Upload Image Error!")
}
```


***Kingfisher 라이브러리를 사용 ⭕️***

```swift
cell.postImageView.setImage(imageUrl: tvShow.backdropImage)
```

---

## #3 CollectionView, Resizing TableView Cell

- 도서 화면을 컬렉션뷰로 구현

<img src = "https://user-images.githubusercontent.com/74236080/137934089-e12ba499-edcb-4e4f-8605-6b11299c0d49.png" width="30%" height="30%">


- Chevron 버튼을 클릭할 때마다 줄거리 전체가 보이고, 다시 클릭하면 줄거리 일부가 보이도록 구현

```swift
var expand = false

...

@objc func TapSeeMoreButton(button: UIButton) {
    expand = !expand
    tableView.reloadRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
}

...

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    ...
    
    summaryCell.summaryLabel.numberOfLines = expand ? 0 : 2
    
    let img = expand ? UIImage(systemName: "chevron.up") : UIImage(systemName: "chevron.down")
    summaryCell.seeMoreButton.setImage(img, for: .normal)
    summaryCell.seeMoreButton.addTarget(self, action: #selector(TapSeeMoreButton(button:)), for: .touchUpInside)
    return summaryCell
    }
    
    ...
}

...

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     if indexPath.row == 0 {
        return UITableView.automaticDimension
     }
     return UIScreen.main.bounds.height / 10
}

```


https://user-images.githubusercontent.com/74236080/138010921-fefa570a-22c4-40d4-824d-09878516a13e.mov


---

## #4 Map

### MapKit 구현

[코드](https://github.com/camosss/SSAC/blob/main/ssacTrendMedia/ssacTrendMedia/VC/MapVC.swift)

```swift
- 사용자가 위치 권한을 허용한 경우에는 맵뷰의 중심을 사용자의 현재 위치로 설정합니다.
- 사용자가 위치 권한을 거부한 경우에는 서울시청이 맵뷰의 중심이 되도록 설정합니다.
- 사용자의 위치를 네비게이션 타이틀에 표시합니다. ( 00구 00동으로 표시 )
- 위치 버튼을 누를 경우, 위치 권한을 거부한 경우라면 Alert을 띄워 iOS 설정 화면으로 유도해주세요. 
```

```swift
주변 영화관을 맵뷰 어노테이션으로 표시합니다.
- 최초 뷰컨트롤러 진입 시 전체 어노테이션을 다 보여주세요.
- 롯데시네마/메가박스/CGV/전체보기로 세그먼트 컨트롤을 만들고, 예를 들어 롯데시네마에 해당하는 값만 맵 어노테이션을 띄워줍니다. 전체보기인 경우에는 모든 어노테이션을 다 표현해주세요. (얼럿이 가능하신 분들은 세그먼트 대신 얼럿으로 구현하시면 됩니다!)
- 얼럿을 띄워 롯데시네마를 클릭한 경우, 롯데시네마에 해당하는 값만 맵 어노테이션을 띄워줍니다.
- 전체보기를 누르면 최초 뷰컨트롤러 진입과 동일하게 전체 어노테이션을 보여주세요.
```


1️⃣   화면을 움직일 때, 지도 중앙에 표시되는 핀의 주소 띄우기

2️⃣   필터버튼 변경

3️⃣   Annotations 코드 정리

4️⃣   권한 관련 코드 다시


- ***핀의 주소***

https://user-images.githubusercontent.com/74236080/138279810-497b0b5c-1401-4550-9cb0-737e4de5b9a8.mov

- ***Annotations***

https://user-images.githubusercontent.com/74236080/138279831-cf5d24cf-44fb-4e2e-b6b7-3fbc1ef095b2.mov


- ***권한 거부 ❌***

https://user-images.githubusercontent.com/74236080/138280933-02f09604-8bf7-4d6f-bea1-345802f6224d.mov

---

## #5 영화진흥위원회 API 구현하기

```swift
영화진흥위원회 API 구현하기
- 영화진흥위원회 API를 통해 어제 날짜 기준으로 일간 박스오피스 정보를 보여
주는 예제입니다.
- 새 프로젝트에 작업해주셔도 되시고, 트렌드 미디어 프로젝트에 작업해주셔도
괜찮습니다.
- 어제 날짜 기준으로 네트워크 통신을 진행하고, Response에서 영화 제목에 관
련된 정보만 문자열 배열에 담아줍니다. 그리고 테이블뷰에 문자열 배열에 담긴
정보를 보여주세요.
- (도전) 처음 네트워크 통신을 할 때, 고정된 날짜값이 아니라 항상 어제 기준의
날짜로 일간 박스오피스 정보를 가지고 오고 싶다면 어떻게 해야 할까요?
```


- ***API Data***

<img src = "https://user-images.githubusercontent.com/74236080/139110615-73b32ea0-b7bc-44a3-b8cf-8e426c963377.png" width="60%" height="60%">




https://user-images.githubusercontent.com/74236080/139110663-3e43394d-2bea-405f-b8a8-df70f002dc58.mov








