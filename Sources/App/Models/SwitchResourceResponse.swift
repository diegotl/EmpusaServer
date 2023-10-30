import Vapor

struct InstallStep: Content {
    enum Operation: String, Content {
        case merge
        case move
    }

    let operation: Operation
    let origin: String
    let destination: String

    static func merge(from origin: String, to destination: String) -> InstallStep {
        .init(
            operation: .merge,
            origin: origin,
            destination: destination
        )
    }

    static func move(from origin: String, to destination: String) -> InstallStep {
        .init(
            operation: .move,
            origin: origin,
            destination: destination
        )
    }
}

struct SwitchResourceResponse: Content {
    struct Release: Content {
        let version: String?
        let assetUrl: URL
        let assetName: String
        let isZipped: Bool
        let installSteps: [InstallStep]

        enum CodingKeys: String, CodingKey {
            case version
            case assetUrl = "asset_url"
            case assetName = "asset_name"
            case isZipped = "is_zipped"
            case installSteps = "install_steps"
        }

        init(
            resource: SwitchResource,
            version: String? = nil,
            assetUrl: URL
        ) {
            self.version = version
            self.assetUrl = assetUrl
            self.assetName = resource.assetFileName
            self.isZipped = resource.isAssetZipped
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
            assetName = resource.assetFileName
            isZipped = resource.isAssetZipped
            installSteps = resource.installSteps
        }
    }

    let name: String
    let stableRelease: Release
    let preRelease: Release?

    enum CodingKeys: String, CodingKey {
        case name
        case stableRelease = "stable_release"
        case preRelease = "pre_release"
    }
}
