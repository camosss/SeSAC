
import Foundation

struct User: Encodable {
    var name: String
    var signUpData: Date
    var age: Int
}

let users: [User] = [
    User(name: "A", signUpData: Date(), age: 30),
    User(name: "B", signUpData: Date(timeInterval: -86400, since: Date()), age: 10),
    User(name: "C", signUpData: Date(timeIntervalSinceNow: 86400*2), age: 20)
]

dump(users)

//▿ 3 elements
//  ▿ __lldb_expr_55.User
//    - name: "A"
//    ▿ signUpData: 2021-12-20 02:50:55 +0000
//      - timeIntervalSinceReferenceDate: 661661455.809267
//    - age: 30
//  ▿ __lldb_expr_55.User
//    - name: "B"
//    ▿ signUpData: 2021-12-19 02:50:55 +0000
//      - timeIntervalSinceReferenceDate: 661575055.809268
//    - age: 10
//  ▿ __lldb_expr_55.User
//    - name: "C"
//    ▿ signUpData: 2021-12-22 02:50:55 +0000
//      - timeIntervalSinceReferenceDate: 661834255.809268
//    - age: 20

let encode = JSONEncoder()
//encode.outputFormatting = .prettyPrinted
//encode.dateEncodingStrategy = .iso8601 // (iso 국제표준화기구)

let format = DateFormatter()
format.locale = Locale(identifier: "ko-KR")
format.dateFormat = "yyyy.MM.dd EEEE"
encode.dateEncodingStrategy = .formatted(format)

do {
    let jsonData = try encode.encode(users)
    guard let jsonString = String(data: jsonData, encoding: .utf8) else { fatalError("Failed") }
    print(jsonString)
} catch {
    print(error)
}

// [{"name":"A","signUpData":"2021.12.20 월요일","age":30},{"name":"B","signUpData":"2021.12.19 일요일","age":10},{"name":"C","signUpData":"2021.12.22 수요일","age":20}]


// prettyPrinted
//[
//  {
//    "name" : "A",
//    "signUpData" : "2021.12.20 월요일",
//    "age" : 30
//  },
//  {
//    "name" : "B",
//    "signUpData" : "2021.12.19 일요일",
//    "age" : 10
//  },
//  {
//    "name" : "C",
//    "signUpData" : "2021.12.22 수요일",
//    "age" : 20
//  }
//]
