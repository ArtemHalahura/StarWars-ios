import UIKit

protocol MainModuleFactory {
    func makeMainModuleOutput(dependencies: AppDependencies) -> (output: MainModuleOutput, presentable: Presentable)
    func makeCategoryListModuleOutput(dependencies: AppDependencies, categoryModels: [CategoryModel]) -> (output: CategoryListModuleOutput, presentable: Presentable)
}

extension ModuleFactoryImp: MainModuleFactory {
    
    func makeMainModuleOutput(dependencies: AppDependencies) -> (output: MainModuleOutput, presentable: Presentable) {
        let viewModel = MainViewModelImp(networkManager: dependencies.networkManager)
        
        let controller = MainViewController(viewModel: viewModel)
        
        return (viewModel, controller)
    }
    
    func makeCategoryListModuleOutput(dependencies: AppDependencies, categoryModels: [CategoryModel]) -> (output: CategoryListModuleOutput, presentable: Presentable) {
        let viewModel = CategoryListViewModelImp(categoryModels: categoryModels)
        
        let controller = CategoryListViewController.controllerInStoryboard(UIStoryboard(name: "Main", bundle: nil))
        controller.viewModel = viewModel
    
        
        return (viewModel, controller)
    }
}
