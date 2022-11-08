import Foundation

protocol MainModuleOutput: AnyObject {
    var onFinishFlow: (() -> Void)? { get set }
    var onCategoryScreen: (() -> Void)? { get set }
}

protocol MainViewModel: AnyObject {
    func showCategoryScreen(at index: Int) 
}

final class MainViewModelImp: MainModuleOutput, MainViewModel {
    
    var onFinishFlow: (() -> Void)?
    var onCategoryScreen: (() -> Void)?
    
    func showCategoryScreen(at index: Int) {
            onCategoryScreen?()
    }
}
