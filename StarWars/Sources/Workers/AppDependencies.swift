import Foundation

struct AppDependencies {
    let networkManager: NetworkManager

    init() {
        networkManager = NetworkManagerImp()
    }
}
