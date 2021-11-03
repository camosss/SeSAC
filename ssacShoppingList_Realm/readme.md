
## ShoppingList Realm Database 구현하기

```swift
- ShoppingList 데이터(즐겨찾기, 할 일 완료 여부, 할 일 목록 등)를 Realm Database에 저장

- 저장된 데이터를 가져와서 테이블뷰에 띄우기

- 즐겨찾기, 할 일 완료 여부 버튼을 클릭

- 스와이프로 할 일을 삭제

- (필터) Alert의 ActionSheet를 통해 할 일 기준 정렬, 즐겨찾기순 정렬, 제목순 정렬 기능
```

---

### #1 Realm Database에 저장, 저장된 데이터 TableView에 띄우기

***`ShoppingList` 테이블을 작성***

```swift
ShoppingList

import Foundation
import RealmSwift

class ShoppingList: Object {
    @Persisted var list: String
    @Persisted var check: Bool
    @Persisted var star: Bool
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(list: String) {
        self.init()
        self.list = list
        self.check = false
        self.star = false
    }
}
```

***ViewController에서 값 저장 및 로드***

```swift
ViewController

let localRealm = try! Realm()
var tasks: Results<ShoppingList>!

...

override func viewDidLoad() {
    super.viewDidLoad()
        
    tasks = localRealm.objects(ShoppingList.self)
}

...

@IBAction func addButton(_ sender: UIButton) {
    guard let text = searchTextField.text else { return }
        
    if text.isEmpty {
        ...
    } else {
        let task = ShoppingList(list: text)
        try! localRealm.write {
            localRealm.add(task)
        }
        tasks = localRealm.objects(ShoppingList.self)
        tableView.reloadData()
    }
    searchTextField.text = ""
}
```

https://user-images.githubusercontent.com/93528918/140048119-b0b41f3a-d1b9-465e-a3a7-0c3f5a1d5085.mov

---


### #2 즐겨찾기, 할 일 완료

**Delegation 패턴을 이용하여 Cell내부의 버튼 이벤트 처리**

```swift
Cell

protocol ShoppingCellDelegate: AnyObject {
    func isChecked(_ cell: ShoppingCell)
    func isStared(_ cell: ShoppingCell)
}

...

weak var delegate: ShoppingCellDelegate?

@IBAction func tapCheck(_ sender: UIButton) {
    delegate?.isChecked(self)
}
    
@IBAction func tapStar(_ sender: UIButton) {
    delegate?.isStared(self)
}
```

- 각 행의 Cell 데이터를 가져오기 위해 Cell의 **indexPath** 값을 가져온다.
- 각 버튼 클릭 시, check, star의 Bool값을 toggle해서 값 업데이트

```swift
ViewController

extension ShoppingListVC: ShoppingCellDelegate {
    func isChecked(_ cell: ShoppingCell) {
        
        let buttonPosition = cell.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        
        let taskToUpdate = tasks[indexPath?.row ?? 0]
        
        try! localRealm.write {
            taskToUpdate.check.toggle()
            tableView.reloadData()
        }
    }
    
    func isStared(_ cell: ShoppingCell) {
        
        let buttonPosition = cell.convert(CGPoint.zero, to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: buttonPosition)
        
        let taskToUpdate = tasks[indexPath?.row ?? 0]
        
        try! localRealm.write {
            taskToUpdate.star.toggle()
            tableView.reloadData()
        }
    }
}
```

**UITableViewDataSource**

- 해당 Cell의 check, star의 Bool값에 따라 버튼 이미지와 cell의 배경을 변경해서 로드

```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingCell", for: indexPath) as! ShoppingCell
    cell.delegate = self // delegate 연결
        
    let row = tasks[indexPath.row]
    cell.listLabel.text = row.list
    cell.listLabel.numberOfLines = 0
        
    cell.checkButton.isSelected = row.check
    if row.check {
        cell.checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        cell.contentView.backgroundColor = .systemGreen.withAlphaComponent(0.5)
    } else {
        cell.checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        cell.contentView.backgroundColor = .white
    }
        
    cell.starButton.isSelected = row.star
    if row.star {
        cell.starButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    } else {
        cell.starButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    return cell
}
```


https://user-images.githubusercontent.com/93528918/140048260-cd128d37-03c1-485c-884e-591fb078ddd2.mov

---

### #3 스와이프로 할 일을 삭제

```swift
override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
}
    
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete {
        let taskToDelete = tasks[indexPath.row]
        try! localRealm.write {
            localRealm.delete(taskToDelete)
        }
        tableView.reloadData()
    }
}
```


https://user-images.githubusercontent.com/93528918/140048279-e1f83f41-4cfb-4c08-971a-530620dca2b5.mov

---

### #4 필터별로 정렬

***정렬기준별로 케이스 설정***

```swift
enum ShoppingListOptions: Int, CaseIterable {
    case toDo
    case favorites
    case title
    case basic
    
    var description: String {
        switch self {
        case .toDo: return "할 일순"
        case .favorites: return "즐겨찾기순"
        case .title: return "제목순"
        case .basic: return "처음으로"
        }
    }
}
```

- 할 일순: `.filter("check == false")` → 체크가 되어있지 않은 값들만 필터처리
- 즐겨찾기순: `.filter("star == true")` → 즐겨찾기 버튼을 누른 값들만 필터처리
- 제목순: `.sorted(byKeyPath: "list", ascending: true)` → KeyPath값에서 리스트제목을 정렬
- 처음으로: 처음 입력순서대로 가져오기

```swift
@IBAction func filterButton(_ sender: UIButton) {
    let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
    for order in ShoppingListOptions.allCases {
        alert.addAction(UIAlertAction(title: order.description, style: .default, handler: { _ in
            self.handleFilter(order)
        }))
    }
        
    let cancel = UIAlertAction(title: "취소", style: .cancel)
        
    alert.addAction(cancel)
    present(alert, animated: true, completion: nil)
}
    
func handleFilter(_ order: ShoppingListOptions) {
    let load = self.localRealm.objects(ShoppingList.self)
        
    if order.description == "할 일순" {
        self.tasks = load.filter("check == false")
    } else if order.description == "즐겨찾기순" {
        self.tasks = load.filter("star == true")
    } else if order.description == "제목순" {
        self.tasks = load.sorted(byKeyPath: "list", ascending: true)
    } else {
        self.tasks = load
    }
    self.tableView.reloadData()
}
```

https://user-images.githubusercontent.com/93528918/140048332-16e2a3fa-ac68-4d18-a14e-acb72fabc07d.mov


