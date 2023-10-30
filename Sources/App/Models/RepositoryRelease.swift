public struct RepositoryRelease: Identifiable, Decodable {
    public let id: Int
    public let tagName: String
    public let name: String
    public let prerelease: Bool
    public let assets: [ReleaseAsset]

    enum CodingKeys: String, CodingKey {
        case id
        case tagName = "tag_name"
        case name
        case prerelease
        case assets
    }
}
