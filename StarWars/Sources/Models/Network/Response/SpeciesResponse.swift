import Foundation

struct MainSpeciesResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [SpeciesResponse]
}

struct SpeciesResponse: Codable {

    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
