import Foundation

protocol CategoryListModuleOutput: AnyObject {
    var onFinishFlow: (() -> Void)? { get set }
}

protocol CategoryListViewModel: AnyObject {
    func getModels() -> [CategoryModel]
}

final class CategoryListViewModelImp: CategoryListModuleOutput, CategoryListViewModel {
    
    var onFinishFlow: (() -> Void)?
    var onCategoryScreen: (() -> Void)?
    
    private var categoryModels: [CategoryModel]
    
    init(categoryModels: [CategoryModel]) {
        self.categoryModels = categoryModels
    }
    
    func getModels() -> [CategoryModel] {
        return categoryModels
    }
}
