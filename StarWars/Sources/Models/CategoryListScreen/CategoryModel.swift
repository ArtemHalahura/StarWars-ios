import Foundation

struct CategoryModel: Hashable {
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: CategoryModel, rhs: CategoryModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}
