import Vapor

struct ReleaseData: Content {
    let version: String?
    let assetUrl: URL
    let assetFileName: String
    let installSteps: [InstallStep]

    enum CodingKeys: String, CodingKey {
        case version
        case assetUrl = "asset_url"
        case assetFileName = "asset_filename"
        case installSteps = "install_steps"
    }

    init(
        resource: SwitchResource,
        version: String? = nil,
        assetUrl: URL
    ) {
        self.version = version
        self.assetUrl = assetUrl
        self.assetFileName = resource.assetFileName
        self.installSteps = resource.installSteps
    }

    init?(
        resource: SwitchResource,
        assetPrefix: String,
        release: RepositoryRelease?
    ) {
        guard
            let release,
            let asset = release.assets.first(where: { $0.name.hasPrefix(assetPrefix) })
        else {
            return nil
        }

        version = release.tagName
        assetUrl = asset.browserDownloadUrl
        assetFileName = resource.assetFileName
        installSteps = resource.installSteps
    }
}
