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
