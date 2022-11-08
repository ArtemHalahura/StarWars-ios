import UIKit

final class PeopleCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "people-collection-view-cell-reuse-identifier"
    
    private let contentContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemnted")
    }
    
    func setup(with text1: String, text2: String) {
        
    }
}

// MARK: - Private
private extension PeopleCollectionViewCell {
    
    func configure() {
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentContainer)
        
        
        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
    }
}
