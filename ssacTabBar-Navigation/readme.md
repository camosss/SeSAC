## TabBarController, NavigationController


<img src = "https://user-images.githubusercontent.com/74236080/136120007-09ed09a6-82fc-4162-a783-2c5f319b08e1.png" width="60%" height="60%">

- 아래 탭바의 갯수는 최대 5개이며, 5개가 넘어가면 More 이 생성된다.
- 표시하지 못한 탭은 More 탭을 클릭하면 2번 view 에서 5, 6번의 탭을 갈 수 있다.
- 3번 view 에서 통해 편집 가능하다.


![more 2021-10-06  12 11 21](https://user-images.githubusercontent.com/74236080/136051011-1e3e0791-827b-4d82-bdc1-15ef62e87dde.png)

---

### ViewController Life Cycle

***viewDidLoad*** - view 가 메모리에 로드되는 시점에 처음 한번만 실행된다.

⬇️

***viewWillApear*** - view 가 화면에 추가되기 직전에 호출된다.

```swift

viewDidLoad 와 viewWillApear 차이

view가 하나일 때는 둘의 역할이 비슷하지만, view 가 여려개일 때는 차이를 보인다. 
처음 view 가 보여질 때는 viewDidLoad 와 viewWillApear 가 둘다 호출되지만, 다른 화면을 갔다가 돌아왔을 때는 viewWillAppear 만 호출된다.
view 가 이미 메모리에 로드되어 있기 때문에 viewDidLoad 는 실행되지 않는다.
```

⬇️

***viewDidAppear*** - view 가 나타난 뒤에 호출된다.

⬇️

***viewWillDisappear*** - view 가 사라지기 직전에 호출된다.

⬇️

***viewDidDisappear*** - view 가 사라지고 난 뒤에 호출된다.


---

### Test

아래와 같이 2 개의 ViewController 에 작성

![code](https://user-images.githubusercontent.com/74236080/136052959-00210418-833c-47d8-8e9a-4ede5e745a1d.png)

1. 처음 view 를 load 할 때

![d](https://user-images.githubusercontent.com/74236080/136053330-5a4c26cc-6fa2-4cb5-bcca-2449165bf652.png)

2. 2번째 view 로 넘어갔을 때, ***viewDidDisappear*** 는 view 가 사라지고 난 뒤에 호출되기 때문에, 2번째 view 가 load 되고 난 뒤, 프린트가 찍힌다.

![v](https://user-images.githubusercontent.com/74236080/136053652-1da56aa8-bb14-4af6-99fd-b1db3f6dd0d3.png)

3. 1번째 view 로 돌아갔을 때, viewDidLoad 는 실행되지 않는다.

![f](https://user-images.githubusercontent.com/74236080/136054025-832a092c-4c46-4f59-af39-ac3ff9605b3e.png)















