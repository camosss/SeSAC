
import UIKit

let json = """
{
"quote_content": "Your body is made to move so move it.",
 "author_name": "Toni Sorenson"
}
"""

// class struct enum
struct Quote: Decodable {
    var quote: String
    var author: String
    
    enum CodingKeys: String, CodingKey { // 항상 내부적으로 생성되어있음
        case quote = "quote_content"
        case author = "author_name"
    }
}

// String -> Data
guard let result = json.data(using: .utf8) else { fatalError("Failed") }
print(result)

let decoder = JSONDecoder()
//decoder.keyDecodingStrategy = .convertFromSnakeCase

// Data -> String
do {                                    // Meta Type
    let value = try decoder.decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}

// Meta Type: 클래스, 구조체, 열거형 등의 유형 자체를 가리킴
// Quote: 인스턴스에 대한 타입, Quote 구조체 자체의 타입은? Quote.Type
let quote: Quote = Quote(quote: "명언", author: "jack")
type(of: quote)

