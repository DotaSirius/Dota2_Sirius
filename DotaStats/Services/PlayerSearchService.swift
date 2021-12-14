import Foundation

protocol PlayerSearchService: AnyObject {
    func playersByName(_ name: String, closure: @escaping (Result<[SearchPlayerResult], HTTPError>) -> Void) -> Cancellable?
}

final class PlayerSearchServiceImp: PlayerSearchService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    @discardableResult
    func playersByName(_ name: String, closure: @escaping (Result<[SearchPlayerResult], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createRequest(name),
            completion: closure
        )
    }

    private func createRequest(_ name: String) -> HTTPRequest {
        HTTPRequest(
            route: "https://api.opendota.com/api/search",
            queryItems: [HTTPRequestQueryItem("q", name)],
            dateDecodingStrategy: JSONDecoder.DateDecodingStrategy.formatted(DateFormatter.ISO8601WithSecondsFormatter)
        )
    }
}
