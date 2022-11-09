import UIKit

final class CategoryListViewController: UICollectionViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, CategoryModel>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, CategoryModel>
    
    var viewModel: CategoryListViewModel!
    private var dataSource: DataSource!
    
    private let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Private
private extension CategoryListViewController {
    
    func configure() {
        configureScreen()
        configureSearchController()
        configureCollectionViewLayout()
        configureDataSource()
        configureSnapshot()
        configureUpdateScreen()
    }
    
    func configureScreen() {
        navigationItem.title = viewModel.titleName
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = .done
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search"
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
        
        viewModel.updateScreen = { [weak self] in
            DispatchQueue.main.async {
                guard let self = self else { return }
                var snapshot = Snapshot()
                snapshot.appendSections([Section.main])
                let model = self.viewModel.getModels()
                snapshot.appendItems(model)
                self.dataSource.apply(snapshot)
            }
        }
    }
}

// MARK: -
extension CategoryListViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showDetailsScreen(at: indexPath.row)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.checkVisibleCell(with: indexPath.row)
    }
}

// MARK: - UISearchResultsUpdating, UISearchBarDelegate
extension CategoryListViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text
        viewModel.searchText(with: text)
    }
}
