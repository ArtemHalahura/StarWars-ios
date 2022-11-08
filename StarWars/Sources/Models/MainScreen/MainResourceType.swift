enum MainResourceType: Int, CaseIterable {
    case people
    case planets
    case films
    case species
    case vehicles
    case starships
    
    var title: String {
        switch self {
        case .people:
            return "People"
        case .planets:
            return "Planets"
        case .films:
            return "Films"
        case .species:
            return "Species"
        case .vehicles:
            return "Vehicles"
        case .starships:
            return "Starships"
        }
    }
    
    var description: String {
        switch self {
        case .people:
            return "people"
        case .planets:
            return "planets"
        case .films:
            return "films"
        case .species:
            return "species"
        case .vehicles:
            return "vehicles"
        case .starships:
            return "starships"
        }
    }
}
