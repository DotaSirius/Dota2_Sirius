import Foundation

protocol PlayerSearchNetworkService: AnyObject {
    func playersByName(_ name: String, completion: @escaping (Result<[Players], HTTPError>) -> Void) -> Cancellable?
}

protocol NetworkService: AnyObject {}

final class NetworkServiceImp: NetworkService {}
