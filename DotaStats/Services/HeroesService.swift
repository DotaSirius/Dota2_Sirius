import Foundation

protocol HeroesService: AnyObject {
    func requestHeroes(_ closure: @escaping (Result<[Hero], HTTPError>) -> Void) -> Cancellable?
}

class HeroesServiceImp: HeroesService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    @discardableResult
    func requestHeroes(_ closure: @escaping (Result<[Hero], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createRequest(),
            completion: closure
        )
    }

    private func createRequest() -> HTTPRequest {
        HTTPRequest(route: "https://api.opendota.com/api/heroes")
    }
}
