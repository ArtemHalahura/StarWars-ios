import UIKit

extension UIViewController {
    func showMessageAlert(title: String?,
                          message: String? = nil,
                          actionButtonTitle: String? = NSLocalizedString("Ok", comment: ""),
                          action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionButtonTitle, style: .default, handler: { _ in
            action?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showConfirmationAlert(title: String?,
                               message: String? = nil,
                               actionButtonTitle: String? = NSLocalizedString("Yes", comment: ""),
                               cancelButtonTitle: String? = NSLocalizedString("No", comment: ""),
                               firstAction: (() -> Void)? = nil,
                               secondAction: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .default, handler: { _ in
            secondAction?()
        }))
        alert.addAction(UIAlertAction(title: actionButtonTitle, style: .default, handler: { _ in
            firstAction?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
