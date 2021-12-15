import Foundation

protocol ProPlayerService: AnyObject {
    func requestProPlayers(_ closure: @escaping (Result<[ProPlayer], HTTPError>) -> Void) -> Cancellable?
}

final class ProPlayerServiceImp: ProPlayerService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    @discardableResult
    func requestProPlayers(_ closure: @escaping (Result<[ProPlayer], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createRequest(),
            completion: closure
        )
    }
    
    private func createRequest() -> HTTPRequest {
        HTTPRequest(
            route: "https://api.opendota.com/api/proPlayers",
            dateDecodingStrategy: JSONDecoder.DateDecodingStrategy.formatted(DateFormatter.ISO8601WithSecondsFormatter)
        )
    }
}

