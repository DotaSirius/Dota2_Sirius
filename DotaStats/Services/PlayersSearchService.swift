import Foundation

protocol PlayerSearchService: AnyObject {
    
    func requestProPlayers(_ closure: @escaping (Result<[ProPlayer], HTTPError>) -> Void) -> Cancellable?
}

final class PlayerSearchServiceImp: PlayerSearchService {
    
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    func requestProPlayers(_ closure: @escaping (Result<[ProPlayer], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(request: createRequest()) { result in
            closure(result)
        }
    }
    
    private func createRequest() -> HTTPRequest {
         HTTPRequest(route: "https://api.opendota.com/api/proPlayers")
    }
}
