## Codable

JSON 데이터를 간편하고 쉽게 Encoding/Decoding 할 수 있게 해준다.

- Encodable+Decodable 프로토콜을 준수하는 프로토콜
- Struct, Class, Enum 모두 Codable을 채택

```swift
public typealias Codable = Decodable & Encodable
```

<img src = "https://user-images.githubusercontent.com/93528918/147404626-4aaa9bd7-15ce-4d7a-b9e7-7bdbeb8c32dc.png" width="50%" height="50%">

<br>

### JSONSerialization vs Codable

아래의 두 코드를 비교해보면 큰 차이는 없어보이지만,

복잡한 JSON구조에서는

- `JSONSerialization`는 내부 값에 대해 매번 타입을 정의하면서 하나하나 벗겨줘야하는 불편함이 있지만,
- `Codable`은 이미 타입의 객체에 값을 할당해 놓았기 때문에 추가적으로 작업할 필요가 없다.

<br>

JSONSerialization

```swift
// data
if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
	if let name = json["name"] as? String {
		print(name) // hyeon
     }
}
```

<br>

Codable

```swift
// data
let decoder = JSONDecoder()
if let json = try? decoder.decode(SimpleJson.self, from: data) {
      print(json.name) // hyeon
}
```

<br>

> 실행 속도
> 

구조가 간편한 JSON을 다룰 때에는 JSONSerialization `>` Codable

그 외 (중첩된 구조, 반복 데이터) 에는 JSONSerialization `<` Codable


<br>

### Codable을 이용한 Encoding

1. Codable 채택 == Decodable & Encodable 채택

```swift
struct Person: Codable {
    var name: String
    var age: Int
}
```

<br>

2. Encodable (Data → JSON)

`encode`  Person의 인스턴스를 Data타입으로 변환

encode안에 올 수 있는 값은 Encodable을 준수하고 있는 타입이어야 한다.

→ Codable 채택으로 Person타입의 인스턴스는 모두 Encodable을 준수한다 !

![스크린샷 2021-12-26 오후 6 52 20](https://user-images.githubusercontent.com/93528918/147404694-6319b2f8-78e7-4b73-ba1a-f69ac4529119.png)


<br>

> throws ⇒ encoding 중 에러를 발생시킬 수 있기 때문에 try와 함께 써줘야 한다.
> 
> 
> 리턴 타입이 Data ⇒ Person 인스턴스의 데이터를 얻는 것
> 

<br>

```swift
let encoder = JSONEncoder()

let A = Person(name: "A", age: 10)

let jsonData = try? encoder.encode(A) // 인스턴스 -> Data타입
print(jsonData)
// Optional(32 bytes)
```

<br>

3. 리턴받은 Data를 json 형식으로 변환

```swift
// Data타입 -> String타입
if let prettyJsonData = jsonData,
	 let jsonString = String(data: prettyJsonData, encoding: .utf8) {
    print(jsonString)
}

// {"name":"A","age":10}
```

<br>

- 해당 코드 추가로 우리가 보던 json 형태로

```swift
encoder.outputFormatting = [.prettyPrinted, .sortedKeys]

// {
//   "age" : 10,
//   "name" : "A"
// }
```

<br>

### Codable을 이용한 Decoding

1. 이전의 Json값을 Decoding

```swift
let jsonString = """
{
  "age" : 10,
  "name" : "A"
}
"""
```

<br>

2. Decodable (JSON → Data)

`decode`  Data를 인스턴스로 변환

→ `Person.self`가 들어간 자리는 `type:` 의 자리 (Decode할 값의 타입)

![스크린샷 2021-12-26 오후 6 53 17](https://user-images.githubusercontent.com/93528918/147404714-f682a507-4e1b-41c8-ad3f-1b3c74521d5a.png)

<br>


```swift
let decoder = JSONDecoder()

var data = jsonString.data(using: .utf8)
print(data)
// Optional(32 bytes)

if let data = data, let myPerson = try? decoder.decode(Person.self, from: data) {
    print(myPerson)
}
// Person(name: "A", age: 10)
```

<br>

> 참고
> 

- [https://zeddios.tistory.com/373](https://zeddios.tistory.com/373)
- [https://learn-hyeoni.tistory.com/45](https://learn-hyeoni.tistory.com/45)
