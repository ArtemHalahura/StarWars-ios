import Foundation

protocol NetworkManager {
    func getPeoples(with page: String, completion: @escaping ((Result<MainPeopleResponse, Error>) -> Void))
    func getPlanets(completion: @escaping ((Result<MainPlanetsResponse, Error>) -> Void))
    func getFilms(completion: @escaping ((Result<MainFilmsResponse, Error>) -> Void))
    func getSpecies(completion: @escaping ((Result<MainSpeciesResponse, Error>) -> Void))
    func getPerson(with url: String, completion: @escaping ((Result<PeopleResponse, Error>) -> Void))
    func searchPeople(type: MainResourceType, text: String, completion: @escaping ((Result<MainPeopleResponse, Error>) -> Void))
}

final class NetworkManagerImp: NetworkManager {
    
    static let configuration: URLSessionConfiguration = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30.0
        config.timeoutIntervalForResource = 30.0
        return config
    }()
    let session = URLSession(configuration: configuration)
    
    func getPeoples(with page: String, completion: @escaping ((Result<MainPeopleResponse, Error>) -> Void)) {
        do {
            let request = try APIRouter.people(page: page).asURLRequest()
            session.dataTask(request: request, completionHandler: completion).resume()
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func getPlanets(completion: @escaping ((Result<MainPlanetsResponse, Error>) -> Void)) {
        do {
            let request = try APIRouter.planets.asURLRequest()
            session.dataTask(request: request, completionHandler: completion).resume()
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func getFilms(completion: @escaping ((Result<MainFilmsResponse, Error>) -> Void)) {
        do {
            let request = try APIRouter.films.asURLRequest()
            session.dataTask(request: request, completionHandler: completion).resume()
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func getSpecies(completion: @escaping ((Result<MainSpeciesResponse, Error>) -> Void)) {
        do {
            let request = try APIRouter.species.asURLRequest()
            session.dataTask(request: request, completionHandler: completion).resume()
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func getPerson(with url: String, completion: @escaping ((Result<PeopleResponse, Error>) -> Void)) {
        do {
            let request = try APIRouter.person(url: url).asURLRequest()
            session.dataTask(request: request, completionHandler: completion).resume()
        } catch let error {
            completion(.failure(error))
        }
    }
    
    func searchPeople(type: MainResourceType, text: String, completion: @escaping ((Result<MainPeopleResponse, Error>) -> Void)) {
        do {
            let request = try APIRouter.searchPeople(type: type, text: text).asURLRequest()
            session.dataTask(request: request, completionHandler: completion).resume()
        } catch let error {
            completion(.failure(error))
        }
    }
}
