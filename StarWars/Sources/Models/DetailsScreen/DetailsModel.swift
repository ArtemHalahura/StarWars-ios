struct DetailsModel {
    let name: String
    let height: String
    let mass: String
    let hairColor: String
    let skinColor: String
    let eyeColor: String
    let birthYear: String
    let gender: String
    let homeworld: String
    let created: String
    let edited: String
    let url: String
    
    init(name: String = "", height: String = "", mass: String = "", hairColor: String = "", skinColor: String = "", eyeColor: String = "", birthYear: String = "", gender: String = "", homeworld: String = "", created: String = "", edited: String = "", url: String = "") {
        self.name = name
        self.height = height
        self.mass = mass
        self.hairColor = hairColor
        self.skinColor = skinColor
        self.eyeColor = eyeColor
        self.birthYear = birthYear
        self.gender = gender
        self.homeworld = homeworld
        self.created = created
        self.edited = edited
        self.url = url
    }
}
