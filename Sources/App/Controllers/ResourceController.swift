import Vapor

final class ResourceController: RouteCollection {
    private var cachedResponse: CachedResponse<[SwitchResourceResponse]>?

    func boot(routes: RoutesBuilder) throws {
        let routes = routes
            .grouped("resources")

        routes.get("list", use: listResources)
    }

    private func listResources(req: Request) async -> [SwitchResourceResponse] {
        await initializeCache(req)

        if let cachedResponse, cachedResponse.isValid {
            return cachedResponse.response
        }

        var response = [SwitchResourceResponse]()

        for resource in SwitchResource.allCases {
            switch resource.source {
            case .github(_, _, let assetPrefix),
                 .forgejo(_, _, let assetPrefix):
                let uri = URI(string: resource.source.releasesUrl.absoluteString)
                let headers = HTTPHeaders([("User-Agent", "Empusa")])

                var releases: [RepositoryRelease]
                do {
                    releases = try await req.client
                        .get(uri, headers: headers)
                        .content
                        .decode([RepositoryRelease].self, as: .json)
                } catch {
                    return cachedResponse?.response ?? []
                }

                let stableRelease = SwitchResourceResponse.Release(
                    resource: resource,
                    assetPrefix: assetPrefix,
                    release: releases.first(where: { !$0.prerelease })
                )

                let preRelease = SwitchResourceResponse.Release(
                    resource: resource,
                    assetPrefix: assetPrefix,
                    release: releases.first(where: { $0.prerelease })
                )

                guard let stableRelease else {
                    continue
                }

                response.append(
                    .init(
                        name: resource.rawValue,
                        stableRelease: stableRelease,
                        preRelease: preRelease
                    )
                )

            case .link(let url, let version):
                response.append(
                    .init(
                        name: resource.rawValue,
                        stableRelease: .init(
                            resource: resource,
                            version: version,
                            assetUrl: url
                        ),
                        preRelease: nil
                    )
                )
            }
        }

        cachedResponse = .init(
            updatedAt: .now,
            response: response
        )

        await persistCache(req)
        return response
    }

    private func initializeCache(_ req: Request) async {
        guard cachedResponse == nil else { return }
        do {
            let cacheFile = try await req.fileio.collectFile(at: "Resources/cache.json")
            let cacheData = Data(buffer: cacheFile)
            cachedResponse = try JSONDecoder()
                .decode(CachedResponse<[SwitchResourceResponse]>.self, from: cacheData)
        } catch {}
    }

    private func persistCache(_ req: Request) async {
        guard let cachedResponse else { return }

        do {
            let data = try JSONEncoder().encode(cachedResponse)
            try await req.fileio.writeFile(
                ByteBuffer(data: data),
                at: "Resources/cache.json"
            )
        } catch {}
    }
}
