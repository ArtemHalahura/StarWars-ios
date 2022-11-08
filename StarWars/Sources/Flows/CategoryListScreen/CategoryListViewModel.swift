import Foundation

protocol CategoryListModuleOutput: AnyObject {
    var onFinishFlow: (() -> Void)? { get set }
    var onDetailsScreen: ((DetailsModel) -> Void)? { get set }
}

protocol CategoryListViewModel: AnyObject {
    var showAlert: ((String) -> Void)? { get set }
    func getModels() -> [CategoryModel]
    func showDetailsScreen(at index: Int)
}

final class CategoryListViewModelImp: CategoryListModuleOutput, CategoryListViewModel {
    
    var onFinishFlow: (() -> Void)?
    var onDetailsScreen: ((DetailsModel) -> Void)?
    
    var showAlert: ((String) -> Void)?
    
    private var categoryModels: [CategoryModel]
    private var networkManager: NetworkManager
    
    init(categoryModels: [CategoryModel], networkManager: NetworkManager) {
        self.categoryModels = categoryModels
        self.networkManager = networkManager
    }
    
    func getModels() -> [CategoryModel] {
        return categoryModels
    }
    
    func showDetailsScreen(at index: Int) {
        let model = categoryModels[index]
        if model.type == .people {
            sendPeopleNetworkRequest(with: model.url)
        } else {
            showAlert?("Sorry, this part is in the works")
        }
    }
}

// MARK: - Network
private extension CategoryListViewModelImp {
    
    func sendPeopleNetworkRequest(with url: String) {
        networkManager.getPerson(with: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    self?.showAlert?(error.localizedDescription)
                    
                case .success(let personResponse):
                    let detailsModel = DetailsModel(name: personResponse.name,
                                                    height: personResponse.height,
                                                    mass: personResponse.mass,
                                                    hairColor: personResponse.hairColor,
                                                    skinColor: personResponse.skinColor,
                                                    eyeColor: personResponse.eyeColor,
                                                    birthYear: personResponse.birthYear,
                                                    gender: personResponse.gender,
                                                    homeworld: personResponse.homeworld,
                                                    created: personResponse.created,
                                                    edited: personResponse.edited,
                                                    url: personResponse.url)
                    
                    
                    self?.onDetailsScreen?(detailsModel)
                }
            }
        }
    }
}
