import UIKit

final class PresentationController: UIPresentationController {
    
    private let dimmingView = UIView()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else {
            return
        }
        
        dimmingView.frame = containerView.bounds
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        dimmingView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3)
        dimmingView.alpha = 0
        containerView.insertSubview(dimmingView, at: 0)
        
        let coordinator = presentedViewController.transitionCoordinator
        coordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.5
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        let coordinator = presentedViewController.transitionCoordinator
        coordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        })
    }
}
