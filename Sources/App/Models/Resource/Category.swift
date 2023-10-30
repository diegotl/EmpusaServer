import Vapor

final class CategoryData: Content {
    let name: String
    var resources: [ResourceData] = []

    init(category: SwitchResourceCategory) {
        self.name = category.displayName
    }
}
