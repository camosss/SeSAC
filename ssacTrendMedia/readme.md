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

### 도서 화면을 컬렉션뷰로 구현

<img src = "https://user-images.githubusercontent.com/74236080/137934089-e12ba499-edcb-4e4f-8605-6b11299c0d49.png" width="30%" height="30%">


### Chevron 버튼을 클릭할 때마다 줄거리 전체가 보이고, 다시 클릭하면 줄거리 일부가 보이도록 구현

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

- [MapVC](https://github.com/camosss/SSAC/blob/main/ssacTrendMedia/ssacTrendMedia/VC/MapVC.swift)

- [Map 정리](https://www.notion.so/Map-87b87d6f0be046c9b2a8fbd54fee1306)

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


1️⃣   권한 요청

2️⃣   Annotations 필터

3️⃣   화면을 움직일 때, 지도 중앙에 표시되는 핀의 주소 띄우기


- ***권한 거부 ❌***

https://user-images.githubusercontent.com/74236080/138280933-02f09604-8bf7-4d6f-bea1-345802f6224d.mov


- ***Annotations***

https://user-images.githubusercontent.com/74236080/138279831-cf5d24cf-44fb-4e2e-b6b7-3fbc1ef095b2.mov



- ***핀의 주소***

https://user-images.githubusercontent.com/74236080/138279810-497b0b5c-1401-4550-9cb0-737e4de5b9a8.mov




---

## #5 영화진흥위원회 API

[SearchVC](https://github.com/camosss/SSAC/blob/main/ssacTrendMedia/ssacTrendMedia/VC/SearchVC.swift)

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


<img src = "https://user-images.githubusercontent.com/74236080/139110615-73b32ea0-b7bc-44a3-b8cf-8e426c963377.png" width="40%" height="40%">

ViewController가 검색창에 응답하기 위해 ***UISearchResultsUpdating*** 프로토콜을 사용해서 검색창에 입력한 정보를 기반으로 검색 결과 업데이트한다.
(searchText에 날짜를 입력하여 데이터를 가져온다.)

```swift
searchController.searchResultsUpdater = self

...

extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        fetchData(date: searchText)
    }
}
```

https://user-images.githubusercontent.com/74236080/139110663-3e43394d-2bea-405f-b8a8-df70f002dc58.mov


---

## #6 TMDB API

[MainVC](https://github.com/camosss/SSAC/blob/main/ssacTrendMedia/ssacTrendMedia/VC/MainVC.swift)

```swift
API: https://developers.themoviedb.org/3/trending/get-trending

- 트렌드 미디어 프로젝트 첫 화면에 daily/weekly 트렌드 정보를 보여줍니다.
Media Type을 movie, tv 중 하나로 설정한 URL을 통해 네트워크 통신 실습을
진행합니다.
- 해당 API에서 제공해주는 response 값들을 확인해보는 연습도 함께 합니다.
- 페이지네이션 기능도 구현해봅니다.
- (도전) Media Type을 all로 설정한 경우에는, tv, movie, person의 정보가 섞
여서 response가 오게되고, 각 Media Type마다 json response 구조는 조금
씩 달라집니다. 하나의 모델에 모든 Media Type의 정보를 포함하고 테이블뷰에
보여주고 싶다면 어떻게 해야 할까요?
```

https://user-images.githubusercontent.com/74236080/139242973-94bbcd77-7ee9-45fa-b889-b51d735fcb6d.mov


---

## #7 Pagenation

```swift

동작구조 <SSAC 21 자료>

1. 테이블뷰 생성 및 프로토콜 선언, 그리고 프로토콜 프로퍼티 (prefetchDataSource)를 테이블뷰에 할당
    a. 테이블뷰를 생성하고 UITableViewDelegate, UITableViewDataSource 프로토콜 선언 후 테이블뷰에 프로퍼티(tableView.delegate = self)를 할당하는 것과 동일한 구조

2. TableView CellForRowAt 메서드가 호출되기 전에 미리 필요한 데이터를 로딩함
    a. prefetchRowAt에서 필요한 데이터를 다운 받는 등의 작업을 진행
    b. 비동기 처리 필요

3. cellForRowAt 메서드가 호출되면 prefetchRowAt에서 미리 로딩해두었던 리소스와 데이터들을 표현

4. 만약 사용자가 빠른 스크롤 등으로 화면에 셀을 보여줄 필요가 없는 경우에는 cancelPrefetchingForRowsAt가 호출되고, 해당 메서드에서 관련 작업을 취소

```

***UITableViewDataSourcePrefetching***

- TableView와 UICollectionView에 사용할 수 있는 UITableViewDataSourcePrefetching 프로토콜은 iOS 10부터 사용가능
- Cell이 디스플레이에 보여지는 Cell 이외의 Cell의 정보를 미리 호출하여 데이터를 받아올 수 있다.

<img src = "https://user-images.githubusercontent.com/74236080/139283460-dd98748a-56c1-48f0-ae21-939be51727eb.png" width="30%" height="30%">

- 두가지 메서드가 있는데, prefetchRowsAt 부분에서는 해당되는 Cell에 필요한 데이터를 미리받아오는 메서드이다.
주로 GCD나 Operation으로 비동기 처리 작업을 명시하고, 10개의 Cell을 미리 받아온다.

- cancelPrefetchingForRowsAt 부분은 필요치 않은 Cell들에 대해 작업을 취소하는 메서드이다.
일반적으로 스크롤 방향이 바뀔 때 필요에 따라 데이터 로딩이 되지 못한 것을 취소하는데 사용할 수 있고, 불필요한 작업을 취소하여 GPU 시간을 줄이는데 좋은 방법

```swift
var page = 1
...
tableView.prefetchDataSource = self
...

func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    print(indexPaths)
    for indexPath in indexPaths {
        if media.count-1 == indexPath.row {
            page += 1
            fetchData()
        }
    }
}
    
func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
    print(#function)
}
```

---


## #8 Cast, Crew API

[DetailVC](https://github.com/camosss/SSAC/blob/main/ssacTrendMedia/ssacTrendMedia/VC/DetailVC.swift)

***Cast, Crew API Data***


<img src = "https://user-images.githubusercontent.com/74236080/139394775-ed50e3ff-5eb6-4ef8-bf28-7cbbee0e0d39.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/139394822-eb34bd0b-d7c1-45c5-9ecf-7cabdbb90600.png" width="30%" height="30%">


```swift
트렌드 미디어 프로젝트 첫 화면(트렌드 정보)이 구현되어 있으실 거에요. 그리고 영화를 선택하면 영화 상세 화면으로 전환이 되게 구현이 되어 있습니다.
- 첫 화면에서 영화 상세 화면으로 movie_id 값을 전달하여, 영화에 대한 Cast, Crew 정보를 보여주세요. (API 문서를 참고해 구현을 합니다)
- Get Credits API 활용
- Cast 정보만 보여주셔도 되시고, (도전)2개의 섹션으로 구분하셔서 Cast와 Crew 모두 보여주셔도 되셔요.
```

- MainVC에서 Media의 id값과 mediaType값을 전달받는다.
- mediaType이 movie인지 tv에 따라 url을 구분
- Cast 와 Crew 각각 데이터를 담을 모델을 생성하고, API로부터 받아온 데이터를 저장
- 섹션을 지정해주고, (OverView, Cast, Crew) 섹션별 Title과 데이터, 높이를 지정
- 프로필이미지 데이터가 없는 경우를 고려


https://user-images.githubusercontent.com/74236080/139394916-0b2f9f31-1d1f-4fdc-9e37-328cfcd70025.mov


---

## #9 WebView

[WebVC](https://github.com/camosss/SSAC/blob/main/ssacTrendMedia/ssacTrendMedia/VC/WebVC.swift)

```swift
- 첫 화면에서 링크 버튼을 클릭했을 때, 웹뷰컨트롤러로 화면전환이 되고 있습니다. 
웹뷰를 활용하고, API에서 알려주는 유투브 링크를 통해 예고편 비디오 등을 실행해보세요.
- Get Videos API 활용
- Response Video 배열 중 0번째 요소에 해당하는 key를 통해 웹뷰로 구현을 해보시면 되셔요.
```

- MainVC에서 Media의 id값과 mediaType값을 전달받는다.
- mediaType이 movie인지 tv에 따라 url을 구분
- **0번째 요소에 해당하는 key를 통해 웹뷰로 구현**이기 때문에
let key = `json["results"][0]["key"].stringValue`

<img src = "https://user-images.githubusercontent.com/74236080/139521716-9a83f2fc-a20f-42ab-8722-468de7a9e1ad.png" width="50%" height="50%">

- Storyboard에서 WebKit View생성하여 UIViewController에 추가
- WebVC에서 WebKit을 임포트하고 key값을 대입한 url을 load

https://user-images.githubusercontent.com/74236080/139521734-624b235a-454f-46e1-a536-9bf0f80433d4.mov





