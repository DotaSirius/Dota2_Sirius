import Foundation

protocol RegionsService: AnyObject {
    @discardableResult
    func requestRegionsDetails(completion: @escaping (Result<[String: String], HTTPError>) -> Void) -> Cancellable?
}

final class RegionsServiceImp: RegionsService {
    private let networkClient: NetworkClient

    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    func requestRegionsDetails(completion: @escaping (Result<[String: String], HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createRequest()
        ) { (result: Result<[String: String], HTTPError>) in
            switch result {
            case .success(let regionsData):
                ConstanceStorage.instance.regionsData = regionsData
            case .failure:
                break
            }
            completion(result)
        }
    }

    private func createRequest() -> HTTPRequest {
        HTTPRequest(route: "https://raw.githubusercontent.com/odota/dotaconstants/master/build/region.json")
    }
}
