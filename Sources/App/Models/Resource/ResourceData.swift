import Vapor

struct ResourceData: Content {
    let name: String
    let diplayName: String
    let additionalDescription: String?
    let stableRelease: ReleaseData
    let preRelease: ReleaseData?

    enum CodingKeys: String, CodingKey {
        case name
        case diplayName = "diplay_name"
        case additionalDescription = "additional_description"
        case stableRelease = "stable_release"
        case preRelease = "pre_release"
    }
}
