import Foundation

protocol MatchesService: AnyObject {
	func requestProMatches(_ closure: @escaping (Result<[Match], HTTPError>) -> Void) -> Cancellable?
}

class MatchesServiceImp: MatchesService {

	private let networkClient: NetworkClient

	init(networkClient: NetworkClient) {
		self.networkClient = networkClient
	}

	@discardableResult
	func requestProMatches(_ closure: @escaping (Result<[Match], HTTPError>) -> Void) -> Cancellable? {
		networkClient.processRequest(request: createRequest()) { result in
			closure(result)
		}
	}

	private func createRequest() -> HTTPRequest {
		 HTTPRequest(route: "https://api.opendota.com/api/proMatches")
	}

}
