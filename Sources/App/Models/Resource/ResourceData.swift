import Vapor

struct ResourceData: Content {
    let name: String
    let displayName: String
    let additionalDescription: String?
    let stableRelease: ReleaseData
    let preRelease: ReleaseData?

    enum CodingKeys: String, CodingKey {
        case name
        case displayName = "display_name"
        case additionalDescription = "additional_description"
        case stableRelease = "stable_release"
        case preRelease = "pre_release"
    }
}
