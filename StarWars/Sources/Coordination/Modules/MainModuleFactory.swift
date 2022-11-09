import UIKit

protocol MainModuleFactory {
    func makeMainModuleOutput(dependencies: AppDependencies) -> (output: MainModuleOutput, presentable: Presentable)
    func makeCategoryListModuleOutput(dependencies: AppDependencies, categoryType: MainResourceType, categoryModels: [CategoryModel]) -> (output: CategoryListModuleOutput, presentable: Presentable)
    func makeDetailsModuleOutput(model: DetailsModel) -> (output: DetailsModuleOutput, presentable: Presentable)
}

extension ModuleFactoryImp: MainModuleFactory {
    
    func makeMainModuleOutput(dependencies: AppDependencies) -> (output: MainModuleOutput, presentable: Presentable) {
        let viewModel = MainViewModelImp(networkManager: dependencies.networkManager)
        
        let controller = MainViewController(viewModel: viewModel)
        
        return (viewModel, controller)
    }
    
    func makeCategoryListModuleOutput(dependencies: AppDependencies, categoryType: MainResourceType, categoryModels: [CategoryModel]) -> (output: CategoryListModuleOutput, presentable: Presentable) {
        let viewModel = CategoryListViewModelImp(categoryModels: categoryModels, categoryType: categoryType, networkManager: dependencies.networkManager)
        
        let controller = CategoryListViewController.controllerInStoryboard(UIStoryboard(name: "Main", bundle: nil))
        controller.viewModel = viewModel
        
        return (viewModel, controller)
    }
    
    func makeDetailsModuleOutput(model: DetailsModel) -> (output: DetailsModuleOutput, presentable: Presentable) {
        let viewModel = DetailsViewModelImp(detailsModel: model)
        
        let controller = DetailsViewController(nibName: DetailsViewController.nameOfClass, bundle: nil)
        controller.viewModel = viewModel
        
        return (viewModel, controller)
    }
}
