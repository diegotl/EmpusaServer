import Vapor

public func configure(_ app: Application) async throws {
    let file = FileMiddleware(
        publicDirectory: app.directory.publicDirectory
    )
    app.middleware.use(file)

    try routes(app)
}
