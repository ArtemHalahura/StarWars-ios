import Foundation

struct MainPlanetsResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PlanetsResponse]
}

struct PlanetsResponse: Codable {

    let name: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name
        case url
    }
}
