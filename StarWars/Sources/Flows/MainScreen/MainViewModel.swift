import Foundation

protocol MainModuleOutput: AnyObject {
    var onFinishFlow: (() -> Void)? { get set }
    var onCategoryScreen: (([CategoryModel], MainResourceType) -> Void)? { get set }
}

protocol MainViewModel: AnyObject {
    var showAlert: ((String) -> Void)? { get set }
    var showLoadingPage: (() -> Void)? { get set }
    var dismissLoadingPage: (((() -> Void)?) -> Void)? { get set }
    func showCategoryScreen(at index: Int)
    func getNumberOfItems() -> Int
    func getTitleForCell(at index: Int) -> String
}

final class MainViewModelImp: MainModuleOutput, MainViewModel {
    
    var onFinishFlow: (() -> Void)?
    var onCategoryScreen: (([CategoryModel], MainResourceType) -> Void)?
    
    var showAlert: ((String) -> Void)?
    var showLoadingPage: (() -> Void)?
    var dismissLoadingPage: (((() -> Void)?) -> Void)?
    
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func showCategoryScreen(at index: Int) {
        let type = MainResourceType(rawValue: index)
        switch type {
        case .people:
            sendPeopleNetworkRequest()
        case .planets:
            sendPlanetsNetworkRequest()
        case .films:
            sendFilmsNetworkRequest()
        case .species:
            sendSpeciesNetworkRequest()
        default:
            showAlert?("Sorry, this part is in the works")
        }
    }
    
    func getNumberOfItems() -> Int {
        return MainResourceType.allCases.count
    }
    
    func getTitleForCell(at index: Int) -> String {
        guard let text = MainResourceType(rawValue: index)?.title else {
            fatalError(#function)
        }
        return text
    }
}

// MARK: - Network
private extension MainViewModelImp {
    
    func sendPeopleNetworkRequest() {
        showLoadingPage?()
        networkManager.getPeoples(with: "1"){ [weak self] result in
            DispatchQueue.main.async {
                self?.dismissLoadingPage? {
                    switch result {
                    case .failure(let error):
                        self?.showAlert?(error.localizedDescription)
                        
                    case .success(let peopleResponse):
                        var categoryModels = [CategoryModel]()
                        peopleResponse.results.forEach { model in
                            let categoryModel = CategoryModel(name: model.name, url: model.url, type: .people)
                            categoryModels.append(categoryModel)
                        }
                        self?.onCategoryScreen?(categoryModels, .people)
                    }
                }
            }
        }
    }
    
    func sendPlanetsNetworkRequest() {
        showLoadingPage?()
        networkManager.getPlanets { [weak self] result in
            DispatchQueue.main.async {
                self?.dismissLoadingPage? {
                    switch result {
                    case .failure(let error):
                        self?.showAlert?(error.localizedDescription)
                        
                    case .success(let peopleResponse):
                        var categoryModels = [CategoryModel]()
                        peopleResponse.results.forEach { model in
                            let categoryModel = CategoryModel(name: model.name, url: model.url, type: .planets)
                            categoryModels.append(categoryModel)
                        }
                        self?.onCategoryScreen?(categoryModels, .planets)
                    }
                }
            }
        }
    }
    
    func sendFilmsNetworkRequest() {
        showLoadingPage?()
        networkManager.getFilms { [weak self] result in
            DispatchQueue.main.async {
                self?.dismissLoadingPage? {
                    switch result {
                    case .failure(let error):
                        self?.showAlert?(error.localizedDescription)
                        
                    case .success(let peopleResponse):
                        var categoryModels = [CategoryModel]()
                        peopleResponse.results.forEach { model in
                            let categoryModel = CategoryModel(name: model.name, url: model.url, type: .films)
                            categoryModels.append(categoryModel)
                        }
                        self?.onCategoryScreen?(categoryModels, .films)
                    }
                }
            }
        }
    }
    
    func sendSpeciesNetworkRequest() {
        showLoadingPage?()
        networkManager.getSpecies { [weak self] result in
            DispatchQueue.main.async {
                self?.dismissLoadingPage? {
                    switch result {
                    case .failure(let error):
                        self?.showAlert?(error.localizedDescription)
                        
                    case .success(let peopleResponse):
                        var categoryModels = [CategoryModel]()
                        peopleResponse.results.forEach { model in
                            let categoryModel = CategoryModel(name: model.name, url: model.url, type: .species)
                            categoryModels.append(categoryModel)
                        }
                        self?.onCategoryScreen?(categoryModels, .species)
                    }
                }
            }
        }
    }
}
