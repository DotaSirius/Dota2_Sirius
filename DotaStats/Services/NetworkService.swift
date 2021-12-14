import Foundation

protocol PlayerSearchService: AnyObject {
    func playersByName(_ name: String, completion: @escaping (Result<[SearchPlayerResult], HTTPError>) -> Void) -> Cancellable?
}

protocol NetworkService: AnyObject {
    
}

final class NetworkServiceImp: NetworkService {

}
