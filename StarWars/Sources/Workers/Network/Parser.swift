import Foundation

class Parser {

    static func parse<T>(_ type: T.Type, from data: Data) throws -> T where T: Codable {
        do {
            let decoder = JSONDecoder()
            let formatter = ISO8601DateFormatter()
            formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
            decoder.dateDecodingStrategy = .custom({ decoder -> Date in
                let container = try! decoder.singleValueContainer()
                let string = try! container.decode(String.self)
                return formatter.date(from: string)!
            })
            let parsedResponse = try decoder.decode(type.self, from: data)
            return parsedResponse
            
        } catch let error {
            print(error)
            throw NetworkError.decodeError
        }
    }
}
