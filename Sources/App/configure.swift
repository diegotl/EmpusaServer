import Vapor

public func configure(_ app: Application) async throws {
    ContentConfiguration.global.use(encoder: JSONEncoder(), for: .json)

    let file = FileMiddleware(
        publicDirectory: app.directory.publicDirectory
    )
    app.middleware.use(file)

    try routes(app)
}
