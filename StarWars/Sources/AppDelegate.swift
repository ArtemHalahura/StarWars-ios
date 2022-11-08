import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private lazy var coordinator: AppCoordinator = buildAppCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator.start()
        window?.makeKeyAndVisible()
        
        return true
    }
}

// MARK: - Private
private extension AppDelegate {
    
    func buildAppCoordinator() -> AppCoordinator {
        return AppCoordinator(window: window!,
                              coordinatorFactory: CoordinatorFactoryImp())
    }
}
