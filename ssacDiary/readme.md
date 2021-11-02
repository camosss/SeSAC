
## #1 다국어 지원 

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

<img src = "https://user-images.githubusercontent.com/93528918/139818762-b4f65961-0f21-482f-bd59-e774faf1d459.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/93528918/139818770-c5c6cc11-2d11-44f8-bb3b-1ed9fd9c0292.png" width="30%" height="30%">


***일본어***

<img src = "https://user-images.githubusercontent.com/93528918/139818786-1c76e721-5ebf-454c-9734-b57eaaba4f9f.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/93528918/139818795-cb334076-8687-47ed-bc8a-412bf71e1541.png" width="30%" height="30%">


***영어***

<img src = "https://user-images.githubusercontent.com/93528918/139818800-9187c76e-6e2b-4a3e-832f-d2903f7ec908.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/93528918/139818811-c038ce80-a7e0-4410-9646-cc551ce1a19b.png" width="30%" height="30%">



