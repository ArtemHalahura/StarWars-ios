import Foundation

protocol CategoryListModuleOutput: AnyObject {
    var onFinishFlow: (() -> Void)? { get set }
    var onCategoryScreen: (() -> Void)? { get set }
}

protocol CategoryListViewModel: AnyObject {
    
}

final class CategoryListViewModelImp: CategoryListModuleOutput, CategoryListViewModel {
    
    var onFinishFlow: (() -> Void)?
    var onCategoryScreen: (() -> Void)?
    
}
