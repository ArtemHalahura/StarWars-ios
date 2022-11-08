protocol MainCoordinatorOutput: AnyObject {
    var onFinishFlow: (() -> Void)? { get set }
}

final class MainCoordinator: BaseCoordinator, MainCoordinatorOutput {
    
    var onFinishFlow: (() -> Void)?
    
    private let router: Router
    private let dependencies: AppDependencies
    private let moduleFactory: MainModuleFactory
    
    init(router: Router, dependencies: AppDependencies, moduleFactory: MainModuleFactory) {
        self.router = router
        self.dependencies = dependencies
        self.moduleFactory = moduleFactory
    }
    
    override func start() {
        showMainScreen()
    }
}

// MARK: - Private
private extension MainCoordinator {
    
    func showMainScreen() {
        let (output, presentable) = moduleFactory.makeMainModuleOutput(dependencies: dependencies)
        
        output.onFinishFlow = {
            print("Finish flow")
        }
        output.onCategoryScreen = { [weak self] in
            self?.showCategoryListScreen()
        }
        router.setRootModule(presentable)
    }
    
    func showCategoryListScreen() {
        let (output, presentable) = moduleFactory.makeCategoryListModuleOutput(dependencies: dependencies)
        
        output.onFinishFlow = {
            print("Finish flow")
        }
        router.push(presentable, animated: true)
    }
}
