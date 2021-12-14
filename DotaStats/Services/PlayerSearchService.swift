//
//  PlayerSearchService.swift
//  DotaStats
//
//  Created by Igor Efimov on 13.12.2021.
//

import Foundation

protocol PlayerSearchService: AnyObject {
    func playersByName(_ name: String, closure: @escaping (Result<[Search], HTTPError>) -> Void) -> Cancellable?
}

final class PlayerSearchServiceImp: PlayerSearchService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    @discardableResult
    func playersByName(_ name: String, closure: @escaping (Result<[Search], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(request: createRequest(name)) { result in
            closure(result)
        }
    }

    private func createRequest(_ name: String) -> HTTPRequest {
        HTTPRequest(
            route: "https://api.opendota.com/api/search",
            queryItems: [HTTPRequestQueryItem("q", name)],
            dateDecodingStrategy: JSONDecoder.DateDecodingStrategy.formatted(DateFormatter.ISO8601WithSecondsFormatter)
        )
    }
}
