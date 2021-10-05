## LED Board

https://user-images.githubusercontent.com/74236080/136049441-d440c375-4a06-4dc2-b148-4e4aec9b6eb3.mov


### 랜덤 색상


```swift
func randomColor() -> UIColor {
    let red = CGFloat(drand48())
    let green = CGFloat(drand48())
    let blue = CGFloat(drand48())
    return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
}

@IBAction func changeTextColor(_ sender: Any) {
    boardText.textColor = randomColor()
}
```
