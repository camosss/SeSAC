
import Foundation

let json = """
{
"quote_content": "Your body is made to move so move it.",
"author": null,
"like_count": 12345
}
"""

struct Quote: Decodable {
    let quote: String
    let author: String?
    let like: Int
    let influencer: Bool
    
    enum CodingKeys: String, CodingKey { // 항상 내부적으로 생성되어있음
        case quote = "quote_content"
        case author
        case like = "like_count"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        quote = try container.decode(String.self, forKey: .quote)
        author = (try? container.decodeIfPresent(String.self, forKey: .author)) ?? "unknown"
        like = try container.decode(Int.self, forKey: .like)
        influencer = (10000...).contains(like) ? true : false
    }
    
}

// String -> Data
guard let result = json.data(using: .utf8) else { fatalError("Failed") }

// Data -> String
do {                                    // Meta Type
    let value = try JSONDecoder().decode(Quote.self, from: result)
    print(value)
} catch {
    print(error)
}


