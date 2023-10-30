import Vapor

struct CachedResponse<T: Content>: Content {
    let updatedAt: Date
    let response: T

    var isValid: Bool {
        Date().timeIntervalSince(updatedAt) < 10 * 60
    }
}
