typealias Parameters = [String: Any]

protocol ParameterEncodable {
    var asParameters: Parameters { get }
}
