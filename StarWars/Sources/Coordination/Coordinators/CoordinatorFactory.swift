import UIKit

protocol CoordinatorFactory {
    func makeMainCoordinator(dependencies: AppDependencies, router: Router) -> Coordinator & MainCoordinatorOutput
}

final class CoordinatorFactoryImp: CoordinatorFactory {
    
    func makeMainCoordinator(dependencies: AppDependencies, router: Router) -> Coordinator & MainCoordinatorOutput {
        let coordinator = MainCoordinator(router: router,
                                          dependencies: dependencies,
                                          moduleFactory: ModuleFactoryImp())
        return coordinator
    }
}

