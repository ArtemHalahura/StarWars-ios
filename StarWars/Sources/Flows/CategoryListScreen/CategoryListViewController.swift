import UIKit

final class CategoryListViewController: UICollectionViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, CategoryModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CategoryModel>
    
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
        configureUpdateScreen() 
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
        let cellRegistration = UICollectionView.CellRegistration { (cell: UICollectionViewListCell, indexPath: IndexPath, model: CategoryModel) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = model.name
            cell.contentConfiguration = contentConfiguration
            cell.accessories = [.disclosureIndicator()]
        }
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, model: CategoryModel) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: model)
        }
    }
    
    func configureSnapshot() {
        var snapshot = Snapshot()
        snapshot.appendSections([Section.main])
        let model = viewModel.getModels()
        snapshot.appendItems(model)
        dataSource.apply(snapshot)
        
        collectionView.dataSource = dataSource
    }
    
    func configureUpdateScreen() {
        viewModel.showAlert = { [weak self] errorString in
            DispatchQueue.main.async {
                self?.showMessageAlert(title: errorString)
            }
        }
    }
}

extension CategoryListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showDetailsScreen(at: indexPath.row)
    }
}
