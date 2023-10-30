import Vapor

public func configure(_ app: Application) async throws {
    ContentConfiguration.global.use(encoder: JSONEncoder(), for: .json)

    try routes(app)
}
