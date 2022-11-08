import Foundation

protocol MainModuleOutput: AnyObject {
    var onFinishFlow: (() -> Void)? { get set }
}

protocol MainViewModel: AnyObject { }

final class MainViewModelImp: MainModuleOutput, MainViewModel {
    
    var onFinishFlow: (() -> Void)?
    
}
