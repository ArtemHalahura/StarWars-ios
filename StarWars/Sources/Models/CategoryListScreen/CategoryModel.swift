import Foundation

struct CategoryModel: Hashable {
    let name: String
    let url: String
    let type: MainResourceType
    
    init(name: String, url: String, type: MainResourceType) {
        self.name = name
        self.url = url
        self.type = type
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: CategoryModel, rhs: CategoryModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}
