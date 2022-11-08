protocol MainModuleFactory {
    func makeMainModuleOutput(dependencies: AppDependencies) -> (output: MainModuleOutput, presentable: Presentable)
}

extension ModuleFactoryImp: MainModuleFactory {
    
    func makeMainModuleOutput(dependencies: AppDependencies) -> (output: MainModuleOutput, presentable: Presentable) {
        let viewModel = MainViewModelImp()
        
        let controller = MainViewController(nibName: MainViewController.nameOfClass, bundle: nil)
        controller.viewModel = viewModel
        
        return (viewModel, controller)
    }
}
