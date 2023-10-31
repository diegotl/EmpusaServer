import Vapor

struct InstallStep: Content {
    enum Operation: String, Content {
        case mergeAll
        case mergeDir
        case moveFile
    }

    let operation: Operation
    let origin: String?
    let destination: String?

    static func mergeAll() -> InstallStep {
        .init(
            operation: .mergeAll,
            origin: nil,
            destination: nil
        )
    }

    static func mergeDir(from origin: String, to destination: String) -> InstallStep {
        .init(
            operation: .mergeDir,
            origin: origin,
            destination: destination
        )
    }

    static func moveFile(from origin: String, to destination: String) -> InstallStep {
        .init(
            operation: .moveFile,
            origin: origin,
            destination: destination
        )
    }
}
