import Foundation

enum NetworkError: Error {
    case networkError
    case decodeError
    
    var localizedDescription: String {
        switch self {
        case .networkError:
            return "NetworkError"
        case .decodeError:
            return "ParsingError"
        }
    }
}
