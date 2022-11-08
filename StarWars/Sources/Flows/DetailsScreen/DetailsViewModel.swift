import Foundation

protocol DetailsModuleOutput: AnyObject {
    var onFinishFlow: (() -> Void)? { get set }
}


protocol DetailsViewModel: AnyObject {
    func getDetailsModel() -> DetailsModel
}

final class DetailsViewModelImp: DetailsModuleOutput, DetailsViewModel {
    
    var onFinishFlow: (() -> Void)?
    
    private let detailsModel: DetailsModel
    
    init(detailsModel: DetailsModel) {
        self.detailsModel = detailsModel
    }
    
    func getDetailsModel() -> DetailsModel {
        return detailsModel
    }
}
