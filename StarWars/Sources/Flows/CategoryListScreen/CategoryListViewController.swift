import UIKit

final class CategoryListViewController: UICollectionViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, String>
    
    var viewModel: CategoryListViewModel!
    private var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Private
private extension CategoryListViewController {
    
    func configure() {
        configureCollectionViewLayout()
        configureDataSource()
        configureSnapshot()
    }
    
    func configureCollectionViewLayout() {
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
    }
    
    func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .grouped)
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, itemIdentifier: String) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = itemIdentifier
            cell.contentConfiguration = contentConfiguration
        }
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, itemIdentifier: String) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
        }
    }
    
    func configureSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(["films", "video", "text", "audio", "films2", "video2", "text2", "audio2"])
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
    }
}
