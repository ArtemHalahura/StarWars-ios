import UIKit

final class MainViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: MainViewController.nameOfClass, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}

// MARK: - Private
private extension MainViewController {
    
    func configure() {
        configureScreen()
        configureCollectionView()
        configureUpdateScreen()
    }
    
    func configureScreen() {
        navigationItem.title = NSLocalizedString("main_screen_navigation_title", comment: "")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        TextCollectionViewCell.register(in: collectionView)
    }
    
    func configureUpdateScreen() {
        viewModel.showAlert = { [weak self] errorString in
            DispatchQueue.main.async {
                self?.showMessageAlert(title: errorString)
            }
        }
        viewModel.showLoadingPage = { [weak self] in
            DispatchQueue.main.async {
                self?.presentLoadingPageController()
            }
        }
    }
    
    func presentLoadingPageController() {
        let loadingPageController = LoadingPageViewController()
        loadingPageController.transitioningDelegate = self
        loadingPageController.modalPresentationStyle = .overFullScreen
        viewModel.dismissLoadingPage = { completion in
            DispatchQueue.main.async {
                loadingPageController.dismiss(animated: true, completion: completion)
            }
        }
        present(loadingPageController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getNumberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TextCollectionViewCell.dequeue(in: collectionView, at: indexPath)
        cell.setup(with: viewModel.getTitleForCell(at: indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.showCategoryScreen(at: indexPath.row)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 100.0)
    }
}

// MARK: - UIViewControllerTransitioningDelegate
extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
