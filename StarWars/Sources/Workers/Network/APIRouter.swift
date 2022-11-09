import Foundation

enum APIRouter {
    
    case people(page: String)
    case planets
    case films
    case species
    case vehicles
    
    case person(url: String)
    
    var baseURL: URL {
        guard let url = URL(string: Configuration.apiBaseUrl) else {
            fatalError("Problem with URL")
        }
        return url
    }
    
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
        case .person:
            return ""
        }
    }
    
    private var method: String {
        switch self {
        case .people, .planets, .films, .species, .vehicles, .person:
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
        var url = baseURL.appendingPathComponent(path)
        
        switch self {
        case .people(let page):
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else { break }
            
            let pageQueryItem = URLQueryItem(name: "page", value: page)
            urlComponents.queryItems = [pageQueryItem]
            
            guard let targetURL = urlComponents.url else { break }
            url = targetURL
            
        case .person(let urlString):
            guard let newURL = URL(string: urlString) else {
                fatalError(#function)
            }
            url = newURL
            
        default:
            break
        }
        
        return url
    }
}
