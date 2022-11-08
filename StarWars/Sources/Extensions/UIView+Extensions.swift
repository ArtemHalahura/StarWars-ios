import UIKit

struct ViewShadow {
    let cornerRadius: CGFloat
    let shadowColor: CGColor
    let shadowOpacity: Float
    let shadowOffset: CGSize
    let shadowRadius: CGFloat
}

extension UIView {
    func addShadow(shadow: ViewShadow) {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = shadow.cornerRadius
        self.layer.shadowColor = shadow.shadowColor
        self.layer.shadowOpacity = shadow.shadowOpacity
        self.layer.shadowOffset = shadow.shadowOffset
        self.layer.shadowRadius = shadow.shadowRadius
    }
}
