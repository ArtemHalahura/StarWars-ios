import UIKit

final class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var nameTitleLabel: UILabel!
    @IBOutlet private weak var nameDescriptionLabel: UILabel!
    
    @IBOutlet private weak var heightTitleLabel: UILabel!
    @IBOutlet private weak var heightDesriptionLabel: UILabel!
    
    @IBOutlet private weak var massTitleLabel: UILabel!
    @IBOutlet private weak var massDescriptionLabel: UILabel!
    
    @IBOutlet private weak var hairColorTitleLabel: UILabel!
    @IBOutlet private weak var hairColorDescriptionLabel: UILabel!
    
    @IBOutlet private weak var skinColorTitleLabel: UILabel!
    @IBOutlet private weak var skinColorDescriptionLabel: UILabel!
    
    @IBOutlet private weak var eyeColorTitleLabel: UILabel!
    @IBOutlet private weak var eyeColorDescriptionLabel: UILabel!
    
    @IBOutlet private weak var genderTitleLabel: UILabel!
    @IBOutlet private weak var genderDescriptionLabel: UILabel!
    
    var viewModel: DetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}

// MARK: - Private
private extension DetailsViewController {
    
    func configure() {
        configureTitleLabels()
        configureDescriptionsLabels()
    }
    
    func configureTitleLabels() {
        nameTitleLabel.font = getFontForTitle()
        nameTitleLabel.text = NSLocalizedString("details_screen_name", comment: "")
        
        heightTitleLabel.font = getFontForTitle()
        heightTitleLabel.text = NSLocalizedString("details_screen_height", comment: "")
        
        massTitleLabel.font = getFontForTitle()
        massTitleLabel.text = NSLocalizedString("details_screen_mass", comment: "")
        
        hairColorTitleLabel.font = getFontForTitle()
        hairColorTitleLabel.text = NSLocalizedString("details_screen_hair_color", comment: "")
        
        skinColorTitleLabel.font = getFontForTitle()
        skinColorTitleLabel.text = NSLocalizedString("details_screen_skin_color", comment: "")
        
        eyeColorTitleLabel.font = getFontForTitle()
        eyeColorTitleLabel.text = NSLocalizedString("details_screen_eye_color", comment: "")
        
        genderTitleLabel.font = getFontForTitle()
        genderTitleLabel.text = NSLocalizedString("details_screen_gender", comment: "")
    }
    
    func configureDescriptionsLabels() {
        let model = viewModel.getDetailsModel()
        
        nameDescriptionLabel.text = model.name
        heightDesriptionLabel.text = model.height
        massDescriptionLabel.text = model.mass
        hairColorDescriptionLabel.text = model.hairColor
        skinColorDescriptionLabel.text = model.skinColor
        eyeColorDescriptionLabel.text = model.eyeColor
        genderDescriptionLabel.text = model.gender
    }
    
    
    func getFontForTitle() -> UIFont? {
        return .boldSystemFont(ofSize: 16.0)
    }
}
