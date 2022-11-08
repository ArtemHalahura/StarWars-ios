import UIKit

final class LoadingPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Private
private extension LoadingPageViewController {
    
    func configure() {
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        modalTransitionStyle = .crossDissolve
    }
}
