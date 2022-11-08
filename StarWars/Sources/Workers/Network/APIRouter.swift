import Foundation

enum APIRouter {
    
    private static let baseURL = URL(string: "https://swapi.dev/api/")!
    
    case people(page: String)
    case planets
    case films
    case species
    case vehicles
    
    private var path: String {
        switch self {
            
        case .people:
            return MainResourceType.people.description
        case .planets:
            return MainResourceType.planets.description
        case .films:
            return MainResourceType.films.description
        case .species:
            return MainResourceType.species.description
        case .vehicles:
            return MainResourceType.vehicles.description
        
        }
    }
    
    private var method: String {
        switch self {
        case .people, .planets, .films, .species, .vehicles:
            return "GET"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = initializeURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        return urlRequest
    }
}

// MARK: - Private
private extension APIRouter {
    func initializeURL() -> URL {
        var url = APIRouter.baseURL.appendingPathComponent(path)
        
        switch self {
        case .people(let page):
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { break }
            
            let pageQueryItem = URLQueryItem(name: "page", value: page)
            urlComponents.queryItems = [pageQueryItem]
            
            guard let targetURL = urlComponents.url else { break }
            url = targetURL
            
        default:
            break
        }
        
        return url
    }
}
