import Vapor

final class ResourceController: RouteCollection {
    private var cachedResponse: CachedResponse<[CategoryData]>?

    func boot(routes: RoutesBuilder) throws {
        let routes = routes
            .grouped("resources")

        routes.get("list", use: listResources)
    }

    private func listResources(req: Request) async -> [CategoryData] {
        await initializeCache(req)

        if let cachedResponse, cachedResponse.isValid {
            return cachedResponse.response
        }

        req.logger.info("Refetching data because cache is invalid")

        var response = [CategoryData]()

        for category in SwitchResourceCategory.allCases {
            let categoryData = CategoryData(category: category)

            for resource in category.resources {
                switch resource.source {
                case .github(_, _, let assetPrefix),
                     .forgejo(_, _, let assetPrefix):
                    let uri = URI(string: resource.source.releasesUrl.absoluteString)
                    let headers = HTTPHeaders([("User-Agent", "Empusa")])

                    var releases: [RepositoryRelease]
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601

                        releases = try await req.client
                            .get(uri, headers: headers)
                            .content
                            .decode([RepositoryRelease].self, using: decoder)
                    } catch {
                        req.logger.error("Failed to fetch release for \(resource.rawValue): \(error.localizedDescription)")
                        if let cachedResponse {
			    return cachedResponse.response
			} else {
			    continue
			}
                    }

                    let stableRelease = ReleaseData(
                        resource: resource,
                        assetPrefix: assetPrefix,
                        release: releases.first(where: { !$0.prerelease })
                    )

                    var preRelease = ReleaseData(
                        resource: resource,
                        assetPrefix: assetPrefix,
                        release: releases.first(where: { $0.prerelease })
                    )

                    guard let stableRelease else {
                        continue
                    }

                    if stableRelease.createdAt ?? .distantFuture > preRelease?.createdAt ?? .distantPast {
                        preRelease = nil
                    }

                    categoryData.resources.append(
                        .init(
                            name: resource.rawValue,
                            displayName: resource.displayName,
                            additionalDescription: resource.additionalDescription,
                            stableRelease: stableRelease,
                            preRelease: preRelease
                        )
                    )

                case .link(let url, let version):
                    categoryData.resources.append(
                        .init(
                            name: resource.rawValue,
                            displayName: resource.displayName,
                            additionalDescription: resource.additionalDescription,
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

            response.append(categoryData)
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
                .decode(CachedResponse<[CategoryData]>.self, from: cacheData)
            req.logger.info("Cache initialized from cache.json")
        } catch {
            req.logger.error("Failed to init cache: \(error.localizedDescription)")
        }
    }

    private func persistCache(_ req: Request) async {
        guard let cachedResponse else { return }

        do {
            let data = try JSONEncoder().encode(cachedResponse)
            try await req.fileio.writeFile(
                ByteBuffer(data: data),
                at: "Resources/cache.json"
            )
        } catch {
            req.logger.error("Failed to persist cache to: \(error.localizedDescription)")
        }
    }
}
