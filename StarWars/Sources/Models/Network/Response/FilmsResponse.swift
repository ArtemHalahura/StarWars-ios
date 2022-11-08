import Foundation

struct MainFilmsResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [FilmsResponse]
}

struct FilmsResponse: Codable {

    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name = "title"
        case url
    }
}
