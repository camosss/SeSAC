## 프로필 정보 저장

`이름`, `키`, `몸무게` 의 데이터를 저장 (set) 하고, 해당 text에 값을 넣어준다.

```swift
    // MARK: - Helper
    
    fileprivate func saveStringData(tf: HoshiTextField, key: String) {
        userDefaults.set(tf.text, forKey: key)
        let update = userDefaults.string(forKey: key)
        tf.text = update
    }
    
    fileprivate func saveDoubleData(tf: HoshiTextField, key: String) {
        userDefaults.set(tf.text, forKey: key)
        let update = userDefaults.double(forKey: key)
        tf.text = "\(update)"
    }
    
    // MARK: - Action
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "프로필 정보 저장", message: nil, preferredStyle: .alert)
        
        let OK = UIAlertAction(title: "OK", style: .default, handler: {_ in
            self.saveStringData(tf: self.nameTextField, key: "name")
            self.saveDoubleData(tf: self.heightTextField, key: "height")
            self.saveDoubleData(tf: self.weightTextField, key: "weight")
        })
        
        let NO = UIAlertAction(title: "NO", style: .destructive, handler: nil)
        
        alert.addAction(OK)
        alert.addAction(NO)
        
        present(alert, animated: true, completion: nil)
    }
```

## Unwind Segue 로 데이터 전달

**ProfileVC** 에서 User 의 `이름`, `키`, `몸무게` 의 데이터를 **MainVC** 로 전달

데이터를 불러오는 쪽인 **MainVC** 에 메서드 작성

```swift
@IBAction func backButton(_ sender: UIStoryboardSegue) {
        
if let vc = sender.source as? ProfileVC {
   if let height = vc.heightTextField.text, let weight = vc.weightTextField.text {
       let intHeight = Double(height) ?? 1, intWeight = Double(weight) ?? 1
       let nickName = vc.nameTextField.text ?? "" // 닉네임

       let recommend = (intHeight + intWeight) / 100 // 권장 섭취량 계산
       let totalNum = userDefaults.integer(forKey: "totalML") // 오늘 마신 양 가져오기
       let goal = Double(totalNum) / Double(recommend) / 10 // 목표 퍼센트 계산
                
       intakeLabel.text = "\(nickName)님의 하루 물 권장 섭취량은 \(recommend)L 입니다."
       todayGoal.text = "목표의 \(Int(goal))%"
       
	// 닉네임, 권장 섭취량, 목표 퍼센트 저장
        userDefaults.set(nickName, forKey: "name")
        userDefaults.set(recommend, forKey: "recommend")
        userDefaults.set(Int(goal), forKey: "goal")
             
       }
    }
}
```

https://user-images.githubusercontent.com/74236080/136707683-92b6f176-db75-47a4-9164-e06cadc68112.mov

---

## 마신 물의 양 추가

1. 추가할 값을 입력할 TextField 인 addValueTextField 의 String 값 text 를 Int 로 형변환
2. `오늘 마신 물의 양` 키값에 저장되어있는 값 가져오기
3. 그 값에 입력한 값을 더해서 저장
4. 더한 값을 가져와서 `totalToday` 에 넣어서 업데이트

그리고 추가한 값을 통해 `목표 퍼센트`를 계산해주고, 이미지를 `case 별`로 업데이트

```swift
@IBAction func addValueButton(_ sender: UIButton) {
        
if let addValue = addValueTextField.text {
    let intAddValue = Int(addValue) ?? 0 // 1. textField의 string값 -> Int로 형변환
            
    let totalNum = userDefaults.integer(forKey: "totalML") // 2. 현재 키값에 저장되어있는 값 가져오기
    userDefaults.set(totalNum + intAddValue, forKey: "totalML") // 3. 그 값에 + textField 값 저장
            
    let updateNum = userDefaults.integer(forKey: "totalML") // 4. + textField 값 가져오기
    totalToday.text = "\(updateNum)ml" // 5. totalToday 값에 update값 넣기
            
     let recommend = userDefaults.double(forKey: "recommend")
     let goal = Double(totalNum) / Double(recommend) / 10
            
      userDefaults.set(goal, forKey: "goal")
            
      if goal < 100 {
          todayGoal.text = "목표의 \(Int(goal))%"
          todayGoal.textColor = .white
       } else {
           todayGoal.text = "목표의 \(Int(goal))%"
           todayGoal.textColor = .red
        }
            
	changeImage(Int(goal))
    }
}
```

https://user-images.githubusercontent.com/74236080/136707696-8963d99f-876f-484f-b788-c9bf93af7fc3.mov

---

## 새로고침

`오늘 마신 물의 양`과 `목표 퍼센트` 를 0으로 저장하고, 값을 가져와서 text 에 넣어준다.

```swift
@IBAction func refreshButton(_ sender: UIBarButtonItem) {
        
   let alert = UIAlertController(title: "초기화 하시겠어요?", message: nil, preferredStyle: .alert)
        
   let OK = UIAlertAction(title: "OK", style: .default, handler: {_ in
       self.userDefaults.set(0, forKey: "totalML") // (1) 데이터를 0으로 저장
       let resetNum = self.userDefaults.integer(forKey: "totalML") // (2) 값을 가져와서
       self.totalToday.text = "\(resetNum)ml" // (3) totalToday 값에 reset값 넣기
       self.totalToday.textColor = .white
            
       self.userDefaults.set(0, forKey: "goal")
       self.todayGoal.text = "목표의 0%"
       self.todayGoal.textColor = .white
    })
        
    let NO = UIAlertAction(title: "NO", style: .destructive, handler: nil)
        
     alert.addAction(OK)
     alert.addAction(NO)
     present(alert, animated: true, completion: nil)
}
```

https://user-images.githubusercontent.com/74236080/136707703-5a17a996-e80c-47e4-8c91-6ae7953f9f71.mov

---

```swift
데이터 전달을 통해 간단하게 끝날 줄 알았는데, 코드가 지저분해지고 메서드 마다 데이터를 가져다 쓰기 위해 각 키값의 데이터를 가져와야해서 복잡해졌다.
구조체로 모델을 구성해서, 구조체에 데이터를 저장하고, 가져와서 계산하는 것이 더 간결할 거 같다.
```
