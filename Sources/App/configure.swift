import Vapor

public func configure(_ app: Application) async throws {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.dateEncodingStrategy = .iso8601

    let jsonDecoder = JSONDecoder()
    jsonDecoder.dateDecodingStrategy = .iso8601

    ContentConfiguration.global.use(encoder: jsonEncoder, for: .json)
    ContentConfiguration.global.use(decoder: jsonDecoder, for: .json)

    let file = FileMiddleware(
        publicDirectory: app.directory.publicDirectory
    )
    app.middleware.use(file)

    try routes(app)
}
