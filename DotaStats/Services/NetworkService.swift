import Foundation

protocol PlayerSearchService: AnyObject {
    func playersByName(_ name: String, completion: @escaping (Result<[Search], HTTPError>) -> Void) -> Cancellable?
}

protocol NetworkService: AnyObject {
    
}

final class NetworkServiceImp: NetworkService {

}
