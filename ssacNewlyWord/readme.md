
## 신조어를 검색하는 앱

1단계: Project Setup & UI

- LaunchScreen
- Main View

<img src = "https://user-images.githubusercontent.com/74236080/136045268-7e21d8a3-51dc-430b-8d62-4199e268425f.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/136045275-08752bde-06da-4e07-a475-ef12d3c6cee1.png" width="30%" height="30%">


2단계: Outlet
- 뷰객체를 Outlet 연결 후, 코드로 UI를 자유롭게 다듬습니다.
- 이 때, 뷰 객체별로 구현되는 코드를 함수로 묶어봅니다. Button 관련 함수, Label 관련 함수 등을 사용자 정의 함수로 표현해보세요.
- 중복되는 UI가 있다면 매개변수를 활용하여 함수로 표현해보세요.

3단계: Tap Gesture
- 탭제스쳐가 실행되면 키보드가 올라와있을 때 키보드를 내려줍니다.

***코드로 작성****

```swift
import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer (target: self,
                                                                  action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
```

https://user-images.githubusercontent.com/74236080/136046159-f26e6094-9042-4191-9474-7f5a359e32b1.mov


4단계: Search Action

- TextField의 Text에 해당하는 의미를 결과 Label 문자열에 표기
- TextField의 Text가 비었거나, 데이터에 해당 검색 Text가 없을 때, 알림 표시


```swift
fileprivate func setAlert(message: String) {
    let alert = UIAlertController(title: "알림",
                                  message: message,
                                  preferredStyle: UIAlertController.Style.alert)
    let okAction = UIAlertAction(title: "확인", style: .default)
        
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
}

@IBAction func searchResult(_ sender: UIButton) {
        
    if wordDictionary[inputText.text!] == nil {
        setAlert(message: "해당하는 신조어를 찾을 수 없습니다.")
    } else {
        resultLabel.text = wordDictionary[inputText.text!]!
    }
}
```

https://user-images.githubusercontent.com/74236080/136046997-4a365c61-0f4f-4ebc-998b-5e45acac53d9.mov

https://user-images.githubusercontent.com/74236080/136047139-2583cf6f-4025-41d2-9504-788c24b5e723.mov


- 버튼의 Text에 해당하는 의미를 결과 Label 문자열에 표기

```swift
@IBAction func searchHashTag(_ sender: UIButton) {
    inputText.text = sender.currentTitle
    resultLabel.text = wordDictionary[inputText.text!]!
}
```

https://user-images.githubusercontent.com/74236080/136047319-287706f4-3d36-4a2f-a1a2-0f60b9b2f1b0.mov



