import UIKit

final class TextCollectionViewCell: UICollectionViewCell, ReusableCollectionViewCell {

    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var customContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func setup(with text: String) {
        textLabel.text = text
    }
}

// MARK: - Private
private extension TextCollectionViewCell {
    
    func configure() {
        textLabel.font = .boldSystemFont(ofSize: 16.0)
        textLabel.textColor = .darkGray
        let shadow = ViewShadow(cornerRadius: 20.0,
                                shadowColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.15),
                                shadowOpacity: 1,
                                shadowOffset: CGSize(width: 0, height: 0),
                                shadowRadius: 4.0)
        customContentView.addShadow(shadow: shadow)
    }
}
