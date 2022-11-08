import UIKit

final class AppCoordinator: BaseCoordinator {
    
    private let router: Router
    private let dependencies: AppDependencies
    private let coordinatorFactory: CoordinatorFactory
    
    init(window: UIWindow, coordinatorFactory: CoordinatorFactory) {
        let navigationController = UINavigationController()
        
        self.coordinatorFactory = coordinatorFactory
        dependencies = AppDependencies()
        router = RouterImp(rootController: navigationController)
        window.rootViewController = navigationController
    }
    
    override func start() {
        runMainCoordinator()
    }
}

// MARK: - Private
private extension AppCoordinator {
    
    func runMainCoordinator() {
        let coordinator = coordinatorFactory.makeMainCoordinator(dependencies: dependencies, router: router)
        
        addDependency(coordinator)
        coordinator.start()
    }
}
