import Foundation

protocol CategoryListModuleOutput: AnyObject {
    var onFinishFlow: (() -> Void)? { get set }
    var onDetailsScreen: ((DetailsModel) -> Void)? { get set }
}

protocol CategoryListViewModel: AnyObject {
    var showAlert: ((String) -> Void)? { get set }
    var updateScreen: (() -> Void)? { get set }
    func getModels() -> [CategoryModel]
    func showDetailsScreen(at index: Int)
    func checkVisibleCell(with lastVisibleIndex: Int)
}

final class CategoryListViewModelImp: CategoryListModuleOutput, CategoryListViewModel {
    
    var onFinishFlow: (() -> Void)?
    var onDetailsScreen: ((DetailsModel) -> Void)?
    
    var showAlert: ((String) -> Void)?
    var updateScreen: (() -> Void)?
    
    private var categoryModels: [CategoryModel]
    private var networkManager: NetworkManager
    
    private var isLoading: Bool = false
    private var pageNumber: Int = 1
    private var isLastPageDownloading: Bool = false
    
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
    
    func checkVisibleCell(with lastVisibleIndex: Int) {
        let model = categoryModels[lastVisibleIndex]
        if model.type == .people {
            if lastVisibleIndex == categoryModels.count - 1 && !isLoading && !isLastPageDownloading {
                pageNumber += 1
                isLoading = true
                sendPeoplesNetworkRequest(with: "\(pageNumber)")
            }
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
    
    func sendPeoplesNetworkRequest(with pageNumber: String) {
        networkManager.getPeoples(with: pageNumber) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .failure(let error):
                    self.showAlert?(error.localizedDescription)
                    
                case .success(let peopleResponse):
                    self.isLoading = false
                    
                    var newCategoryModels = [CategoryModel]()
                    peopleResponse.results.forEach { model in
                        let categoryModel = CategoryModel(name: model.name, url: model.url, type: .people)
                        newCategoryModels.append(categoryModel)
                    }
                    self.categoryModels.append(contentsOf: newCategoryModels)
                    
                    if self.categoryModels.count >= peopleResponse.count {
                        self.isLastPageDownloading = true
                    }
                    self.updateScreen?()
                }
            }
        }
    }
}
