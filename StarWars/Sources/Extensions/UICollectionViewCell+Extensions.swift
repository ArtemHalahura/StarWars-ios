import UIKit

protocol ReusableCollectionViewCell {
    static var identifier: String { get }
    static var nib: UINib? { get }
    static func register(in collectionView: UICollectionView)
    static func dequeue(in collectionView: UICollectionView, at indexPath: IndexPath) -> Self
}

extension ReusableCollectionViewCell where Self: UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib? {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func register(in collectionView: UICollectionView) {
        if let nib = self.nib {
            collectionView.register(nib, forCellWithReuseIdentifier: identifier)
        } else {
            collectionView.register(Self.self, forCellWithReuseIdentifier: identifier)
        }
    }
    
    static func dequeue(in collectionView: UICollectionView, at indexPath: IndexPath) -> Self {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
                as? Self else {
            fatalError("Wrong cell id")
        }
        return cell
    }
}
