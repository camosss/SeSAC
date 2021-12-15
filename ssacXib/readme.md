**📌   Apple이 지원하는 XIB 연결뿐만 아닌, 이니셜라이저와 nib호출을 통해 UIView를 확장해 XIB 사용이 가능하다.**


## XIB를 이용해서 Custom View 제작

**File Owner에 Custom Class 적용**

1. 생성한 Custom Class를 File Owner에 적용

![스크린샷 2021-12-13 오후 3 57 25](https://user-images.githubusercontent.com/93528918/145775968-b207845e-f922-430a-898d-906861db4c7e.png)![스크린샷 2021-12-13 오후 3 59 41](https://user-images.githubusercontent.com/93528918/145775977-e00f3342-ab1a-4f6e-a16e-7e596a9b1d23.png)



2. XIB를 View로 불러오기


> `xib`로 구성한 View를 가져오기 위해서 `nib`형태로 불러와서 등록하고, Custom View에 `addSubView`를 실행



```swift
SquareBoxView

required init?(coder: NSCoder) {
    super.init(coder: coder)
    loadView()
}

func loadView() {
    let view = UINib(nibName: "SquareBoxView", bundle: nil)
		.instantiate(withOwner: self, options: nil).first as! UIView
    view.frame = bounds // view의 frame을 SquareBoxView의 bounds로 설정
    self.addSubview(view)
}
```

***.first***

File Owner에는 여러개의 View를 가질 수 있기 때문에, 이 중에서 Interface Builder로 Custom한 Class를 가져와 현재 View에 계층을 한 단계 더 쌓은 구조

---

## 이니셜라이저

UIView는 **NSCoding 프로토콜**을 상속 받고 있다.

이 프로토콜은 표준 키 기반 아카이브를 통해서 직렬화가능한 Class에 적용되는데, nib 파일에 들어갈 수 있는 모든 클래스는 이 프로토콜을 따르고 있다.

![Untitled](https://user-images.githubusercontent.com/93528918/145776289-8dc7248e-0a8e-4d40-8e6d-5b7c1012a608.png)


***👉 두 initializer의 차이는 Interface Builder로 불러올 때와 코드로 생성할 때, 각각 불린다는 차이가 있다.***


### **required init?(coder: NSCoder)**

> *Returns an object initialized from data in a given unarchiver (공식문서)*
> 

***unarchive***

- 스토리보드나 xib를 활용하면 코드를 작성하지 않고 앱의 속성을 수정할 수 있는데, 이것을 가능하게 해주는 과정

- Interface builder는 코드가 아니기 때문에 앱을 컴파일 하는 시점에서 컴파일러가 인식할 수 없고, 이를 코드로 변환해주는 unarchiving 과정이 필요하다는 것이다.

- 이 과정에서 init?(coder:)가 사용된다.

- 파라미터인 `coder`를 통해 NSCoder 타입의 object가 전달되는 것이다. 전달된 NSCoder 타입의 object가 decoding 되어 초기화된 후 컴파일 할 수 있게 decoding 된 자기자신(self)를 반환하는 작업이라고 볼 수 있다. 

### **override init(frame: CGRect)**

- 스토리보드, xib, nib과 같은 interface builder를 사용하지 않고, 코드로 UIView class의 View object를 만들기 위해 지정된 이니셜라이저

- 그래서 코드로 작성하려는 label, button, view 등 frame을 가진 모든 view 객체는 해당 이니셜라이저 안에서 초기화가 되어야한다.

- 우리가 일반적으로 UIView를 생성하고 Nib으로 생성자를 생성하면 매번 이런 오류가 나오는데,

![Untitled (1)](https://user-images.githubusercontent.com/93528918/145776422-b0b316f0-9b5d-43e9-b309-3bdd55734746.png)


모든 View는 NSCoding을 채택하고 있고, 해당 init(coder:) required이기 때문에

코드로 UI작성을 할 때는 해당 이니셜라이저를 사용하지 않음에도 불구하고, View를 구현할 때 선언해주어야한다.

---

## nib 로드(코드에서 .xib 파일들을 생성하여 참조)

> 컴파일을 하기 위해 nib으로 변환한 뒤 (시스템에서 nib파일을 unarchive), nib파일을 로드
> 

Interface builder는 코드가 아니기 때문에 앱을 컴파일 하는 시점에서 컴파일러가 인식할 수 없고, 이를 코드로 변환해주는 unarchiving 과정이 필요하다.

```swift
xib: XML Interface Builder (태그 형태의 마크업 언어)
XCode가 Interface Builder를 통해 시각적으로 제어 가능하도록 제공

nib: NeXT Interface Builder
뷰의 layout, display등의 요소들을 object graph로 만들어서 직렬화한 파일
```

### UINib

- UINib Class는 nib 파일의 컨텐츠를 래핑하는 객체

- UINib 객체는 nib 파일의 컨텐츠(View)를 메모리에 캐시하고 있다가, `instantiate`할 때 unarchiving한다.

```swift
let view = UINib(nibName: "SquareBoxView", bundle: nil)
		.instantiate(withOwner: self, options: nil).first as! UIView
```

### Bundle.main.loadNibNamed

- nib 파일을 이름으로 찾아서 메모리에 로드하여, nib파일 내의 top-level 객체들을 [Any]? 타입으로 반환

```swift
let view = Bundle.main.loadNibNamed("SquareBoxView", owner: self, options: nil)
```

---

## @IBInspectable, @IBDesignable

### **@IBInspectable**

- 스토리보드에 inspector에서 해당 인터페이스 요소의 속성을 변경할 수 있게 하는 것

- 여기서 값을 변경하는 것이 바로 `set 연산`

![스크린샷 2021-12-13 오전 11 26 27](https://user-images.githubusercontent.com/93528918/145776715-b751ae6c-0f15-4d6b-b3c7-925044929665.png)


```swift
@IBInspectable var cornerRadius: CGFloat {
    get {
        return layer.cornerRadius
    }
    set {
        layer.cornerRadius = newValue
    }
}

@IBInspectable var borderWidth: CGFloat {
    get {
        return layer.borderWidth
    }
    set {
        layer.borderWidth = newValue * 2
    }
}

@IBInspectable var borderColor: UIColor {
    get {
        return UIColor(cgColor: layer.borderColor!)
    }
    set {
        layer.borderColor = newValue.cgColor
    }
}
```

### **@IBDesignable**

- @IBInspectable만 지정하면 "런타임"에 속성이 적용된 것을 볼 수 있지만,

- @IBDesignable는 "**컴파일타임**"으로 실시간으로 보는 것을 가능하게 해준다.

![스크린샷 2021-12-13 오전 11 28 22](https://user-images.githubusercontent.com/93528918/145776752-f2f33cc2-b7a2-459e-b6ee-fc39e44aedff.png)


```swift
@IBDesignable
class MainActivateButton: UIButton {
		...
}
```


---
---

## AppDelegate, SceneDelegate

> **iOS13 이하의 버전까지는 App하나가 오로지 각각 하나의 Process와 UI를 유지했다.**
> 

AppDelegate에서 모두 관여하며 앱의 생명주기(앱의 실행과 종료 등) 및 UI 라이프사이클(백그라운드 상태 로직 등)을 모두 처리

- **Process Lifecycle**: Process 상태
- **UI Lifecycle**: active, inactive, background, foreground 상태 관여

## iOS13 이상 버전


### 📌  **iPadOS가 등장하면서 여러 UI 인스턴스가 존재 가능**

UI Lifecycle이 다양해지면서 **SceneDelegate**가 이를 관리하기 위해 도입되었다.

iOS12까지는 대부분 하나의 앱에 하나의 `window`였지만, iOS13부터는 window의 개념이 `scene`으로 대체되고 아래의 사진처럼 하나의 앱에서 여러개의 scene을 가질 수 있다.


> **Scene**
> 
> UIKit는 UIWindowScene 객체를 사용하는 앱 UI의 각 인스턴스를 관리합니다.
> **Scene에는 UI의 하나의 인스턴스를 나타내는 windows와 view controllers가 들어있습니다.**
> 또한 각 **scene에 해당하는 UIWindowSceneDelegate 객체**를 가지고 있고, 이 객체는 **UIKit와 앱 간의 상호 작용을 조정**하는 데 사용합니다. 
> 
> Scene들은 같은 메모리와 앱 프로세스 공간을 공유하면서 서로 동시에 실행됩니다. **결과적으로 하나의 앱은 여러 scene과 scene delegate 객체를 동시에 활성화**할 수 있습니다.
> 
> *(Scenes - Apple Developer Document 참고)*
> 

<img src = "https://user-images.githubusercontent.com/93528918/146193899-7efe4aab-4788-4607-b254-b547cca9cdec.png" width="50%" height="50%">



### 📌  **AppDelegate에 있는 메소드들이 SceneDelegate로 마이그레이션**

AppDelegate의 역할 중 UI의 상태를 알 수 있는 `UILifecycle`에 대한 부분을 **SceneDelegate**가 처리


![Untitled (1)](https://user-images.githubusercontent.com/93528918/146193938-ab9c79b8-2b17-4574-a1cf-0b9c152429ce.png)


### 📌  **AppDelegate에 `Session Lifecycle`에 대한 역할 추가**

> Scene Session은 앱에서 생성한 모든 scene의 정보를 관리한다.
> 
> Scene Session이 생성되거나 삭제될 때, **AppDelegate**에 알리는 두 메소드가 추가되었다.
> 

- **Called when a new scene session is being created.**

새로운 Scene이 필요할 때마다 `configurationForConnecting` 메서드가 호출되고, Scene이 추가되면 SceneDelegate에서 `willConnectTo`가 호출된다.

- **Called when the user discards a scene session.**

Scene을 영구적으로 삭제할 때 호출된다.


```swift
// MARK: UISceneSession Lifecycle

func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
}

func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
```

---

### 📌  App을 눌렀을 때 호출 순서


> **앱 클릭**
> 
1. **application(_:didFinishLaunchingWithOptions:)**

Delegate에게 실행 프로세스가 거의 끝나고 앱이 실행될 준비가 거의 되었음을 알림

`화면에는 앱이 뜨지 않은 상태`

2. **scene(_:willConnectTo:options:)** 

scene이 앱에 추가될 때 호출

`화면에 앱 등장`

3. **sceneWillEnterForeground(_:)** 

scene이 foreground로 진입할 때 호출

4. **sceneDidBecomeActive(_:)**

app switcher에서 선택되는 등 scene과의 상호작용이 시작될때 호출

`app switcher` 화면을 위로 스와이프했을 때, 현재 실행 중인 앱들이 보이는 화면

---

> **앱 스와이프로 홈화면으로 갈 때**
> 

1. **sceneWillResignActive(_:)**

사용자가 scene과의 상호작용을 중지할 때 호출 (다른 화면으로의 전환과 같은 경우)

2. **sceneDidEnterBackground(_:)**

백그라운드 상태로 전환된 직후 호출


> **앱 스와이프로 종료**
> 

1. **sceneWillResignActive(_:)**

2. **sceneDidDisconnect(_:)**

scene의 연결이 해제될 때 호출



---

> 참고
> 

- https://velog.io/@inwoodev/iOS-initframe-initcoder

- https://ios-development.tistory.com/311

- https://user-images.githubusercontent.com/93528918/146193899-7efe4aab-4788-4607-b254-b547cca9cdec.png

- https://velog.io/@dev-lena/iOS-AppDelegate%EC%99%80-SceneDelegate





