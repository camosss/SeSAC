## Index
- [MVC](#MVC)
- [MVVM](#MVVM)

<br>

## MVC

로그인 기능 **MVC** 패턴 적용

<br>

### ✓ Model


**데이터에 관한 로직 담당 (데이터 값 변경 및 관리)**

- 앱이 **무엇**인지에 대해 관심, 앱이 가지는 데이터들을 정의
- UI와 독립되어있다.
- 모든 의사소통은 Controller를 통해 전달

<br>

> 로그인에 필요한 `토큰 값`과 `id`, `username`, `email`과 같은 데이터를 모델에서 정의
> 

```swift
struct User: Codable {
    let jwt: String
    let user: UserClass
}

struct UserClass: Codable {
    let id: Int
    let username, email: String
}
```

<br>

### ✓ View


**사용자에게 보여지는 화면을 담당 (UI)**

- UILabel, UIButton, UIViewController와 같은 UI와 관련된 것이고, Controller의 통제를 받게 된다.
- Controller가 화면에 무엇을 보여주기 위해 사용되는 요소
- 사용자에게 입력을 받아 Controller를 통해 Model을 업데이트
- 어떤 ViewController 클래스에 속해 있는지 모르는 상태

<br>

> - 이름과 비밀번호를 입력할 `TextField`와 로그인 버튼(`UIButton`)의 UI를 구성하는 코드들이 포함
> - `UIButton`의 **Action**은 **Controller**에서 처리


```swift
protocol ViewRepresentable {
    func setupView()
    func setupConstraints()
}

class SignInView: UIView, ViewRepresentable {
    
    // MARK: - Properties
    
    let usernameTextField = UITextField()
    let passwordTextField = UITextField()
    let signInButton = UIButton()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helper
    
    func setupView() {
        addSubview(usernameTextField)
        addSubview(passwordTextField)
        addSubview(signInButton)
    }
    
    func setupConstraints() {
        usernameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(50)
        }
        
        passwordTextField.snp.makeConstraints { make in
         ...
    }
}
```

<br>

### ✓ Controller


**Model과 View 연결 (Model 값을 View에 보여준다)**

- **어떻게** 화면에 표시할 것인지에 대해 관심
- 항상 접근이 가능, Model에 대한 모든 것을 알고있다.
- 아울렛 변수나 인스턴스 변수를 통해 View에 항상 접근

<br>

> - `signInView` 인스턴스를 통해 View에 접근
> - `UIButton`의 Action 처리를 통해 API 호출을 하여 생성한 Model에 데이터를 저장하고, 이를 바탕으로 UI(View)를 그린다.
> 


```swift
class SignInViewController: UIViewController {

    // MARK: - Properties
    
    let signInView = SignInView()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }

    // MARK: - Action
    
    @objc func signInButtonClicked() {
        guard let username = signInView.usernameTextField.text else { return }
        guard let password = signInView.passwordTextField.text else { return }

        APIService.login(identifier: username, password: password) { userData, error in
            guard let userData = userData else { return }
            print(username, password, userData)
            
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            ...

            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
            
        }
        
    }
}
```

<br>

## 관계


**Model & Controller**

- Controller는 모델에 직접적으로 접근할 수 있지만, Model은 Controller에 **Notification** / **KVO** 등을 통해 Controller에게 Model의 변화를 알린다.

<br>

**Model & View**

- Model은 UI에 독립적이며, View와 소통할 수 없으며 View 또한 불가능

<br>

**View & Controller**

- Controller는 View에 대해 outlet을 이용해 View에게 직접적으로 접근 가능
- View는 Controller에게 구조적으로 미리 정해진 방식으로 Controller에게 행위에 대한 요청(delegate)과 데이터에 대한 요청(data source)을 할 수 있다.
- action(View) - target(Controller)의 구조로 사용자의 행위에 따라 필요한 함수를 호출할 수 있다.


<br>

## MVVM

로그인 기능 **MVVM** 패턴 적용

![다운로드](https://user-images.githubusercontent.com/93528918/147460946-dc4f1c7d-aac5-42a1-bac8-699ecb2c90fc.png)

<br>

- View와 Model을 분리
- 기존의 View는 단순히 UI를 표시하기 위한 로직만을 담당하고, 그 외에는 메서드 호출 정도만 있는 것이 이상적
- ViewModel은 기존의 UIKit을 import할 필요 없이 **데이터 update** 및 **View 요소를 업데이트**한다.
- View - Model - ViewModel 모두 독립적으로 테스트가 가능하다.

<br>

### ✓ Model


- 데이터 구조를 정의하고 ViewModel에게 결과를 알려준다.

- Model은 View와 이어지지 않는다.

`MVC 코드와 동일`

<br>

### ✓ View


- 사용자와의 상호작용을 통해 이벤트가 일어나면 ViewModel에게 알려준다.

- ViewModel이 업데이트 요청한 데이터를 보여준다.

`MVC 코드와 동일`

<br>

### ✓ ViewModel



**Model 데이터를 View에 맞게 가공 및 처리 (View에 반영될 데이터 비즈니스 로직 담당)**

- 사용자의 상호작용을 View가 보내주면 그에 맞는 이벤트를 처리한다.
- Model의 RUD를 담당한다.

<br>

> `MVC`에서 **Controller**에서 처리하던 API 호출 메서드를 `MVVM`에서는 **ViewModel**을 통**해 Model** 데이터를 처리한다.
> 


```swift
import Foundation

class SignInViewModel {
    
    var username: Observable<String> = Observable("유저네임")
    var password: Observable<String> = Observable("")
    
    func postUserLogin(completion: @escaping () -> Void) {
        
        APIService.login(identifier: username.value, password: password.value) { userData, error in
            guard let userData = userData else { return }

            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "username")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            completion()
        }
        
    }
}
```

<br>

### ✓ Controller



1. `ViewModel`의 인스턴스를 생성
2. `ViewModel`의 username, password가 `View`의 usernameTextField, passwordTextField와 **Bind**

<br>

> ***Bind.***  옵저버를 사용해서 UI와 옵저버블을 하나로 묶는 행위로, 새로 생성되는 값을 넘겨줄 때 쓰는 용도
> 

3. TextField의 데이터가 변경되면 (`@objc func ~TextFieldDidChange`) ViewModel에 변경 사항을 알린다.
4. ViewModel의 데이터가 변경됨에 따라 변경된 데이터가 TextField에 Binding된다.

<br>

```swift
class SignInViewController: UIViewController {

    // MARK: - Properties
    
    let signInView = SignInView()
    let viewModel = SignInViewModel()
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = signInView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAddTarget()
        bindingViewModel()
    }
    
    // MARK: - Helper
    
    func bindingViewModel() {
        viewModel.username.bind { text in
            self.signInView.usernameTextField.text = text
        }
        
        viewModel.password.bind { text in
            self.signInView.passwordTextField.text = text
        }
    }
    
    func setAddTarget() {
        signInView.usernameTextField.addTarget(self, action: #selector(usernameTextFieldDidChange(_:)), for: .editingChanged)
        signInView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        signInView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }

    // MARK: - Action
    
    @objc func usernameTextFieldDidChange(_ textfield: UITextField) {
        viewModel.username.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFieldDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }
    
    @objc func signInButtonClicked() {
        viewModel.postUserLogin {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }
}
```
<br>

> 참고

- [https://www.edwith.org/swiftapp/lecture/26620?isDesc=false](https://www.edwith.org/swiftapp/lecture/26620?isDesc=false)
- [https://42kchoi.tistory.com/292](https://42kchoi.tistory.com/292)


