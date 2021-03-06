
## 넷플릭스 메인화면, 로그인화면 구현

<br />

## 메인화면 UI

- 뷰 객체를 아울렛 연결 후, UI를 코드를 통해 개선
- 재생 버튼을 클릭하면 랜덤으로 이미지뷰 4개의 포스터가 변경이 되게 구현

https://user-images.githubusercontent.com/74236080/136038698-322e7e69-a58c-42f5-b9c8-a079b59af58e.mp4

<br />

## 로그인화면

**1단계: UI**

- SignUpViewController 클래스를 생성해 스토리보드 씬과 연결 후, 코드가 필요한 뷰 객체를 아울렛으로 연결
- 5개의 UITextField 에 대한 UI 속성을 코드로 구현
- 1개의 UIButton 에 대한 UI 속성을 코드로 구현
- 1개의 UISwitch 에 대한 UI 속성을 코드로 구현

<br />

**2단계: Switch Action**

- 사용자가 Switch를 토글하면 3개의 TextField를 숨겼다가 보여주는 기능을 구현
- Switch의 @IBAction이 필요. Event는 Value Changed
- Switch의 상태(켜진 상태인지, 꺼진 상태인지)에 대한 여부를 isOn 속성을 통해 확인 후, isOn 이 true인지, false인지에 따라 3개의 TextField를 isHidden 처리

<br />

https://user-images.githubusercontent.com/74236080/136039391-abf871d6-2252-43c3-8c1b-932e6178b3e3.mp4

<br />

**3단계: Tap Gesture**

- 사용자가 TextField에 텍스트를 입력하다, 루트뷰를 탭 하면 키보드가 내려가는 기능을 구현

<br />

https://user-images.githubusercontent.com/74236080/136040660-43d360e5-662d-46aa-9716-922912250e59.mov

<br />

**4단계: alert**

- 이메일과 비밀번호를 정확하게 입력하지 않으면 알림
- 추천코드는 숫자만 허용

<br />

<img src = "https://user-images.githubusercontent.com/74236080/136041858-81a8d92b-b9b3-4fe0-887b-c0528b52b4df.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/136041861-81867fcc-32c5-489c-82f3-7719013ede2c.png" width="30%" height="30%">

<br />

**5단계: 결과 확인하기**
- 사용자가 회원가입 버튼을 클릭하면, 텍스트필드에 입력한 내용이 디버그 영역에 출력

```swift
@IBAction func signUP(_ sender: UIButton) {
        
        if ID.text!.isEmpty || PW.text!.isEmpty || PW.text!.count < 6 {
            setAlert(message: "ID 와 PW 를 정확히 입력해주세요. (PW 는 6자리 이상으로 입력해주세요)")
        } else if Int(CODE.text!) == nil {
            CODE.text = ""
            setAlert(message: "추천 코드는 숫자로만 입력해주세요.")
            
        } else {
            let resultText = """
                    회원가입 정보 확인
                    ID: \(ID.text!)
                    PW: \(PW.text!)
                    NICK: \(NICK.text!)
                    LOCATION: \(LOCATION.text!)
                    CODE: \(CODE.text!)
                    """
                    print(resultText)
        }
        
    }
```
<br />

<img src = "https://user-images.githubusercontent.com/74236080/136041234-3aead93f-8f8b-4332-b8e9-7e8769f2e10f.png" width="30%" height="30%"><img src = "https://user-images.githubusercontent.com/74236080/136041246-c33396b5-65e8-4a9a-942f-1cb127604a5e.png" width="30%" height="30%">
