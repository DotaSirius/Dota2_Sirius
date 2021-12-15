import Foundation

enum SearchPlayerModulePresenterState {
    case none
    case loading(Cancellable?)
    case success([PlayerInfoFromSearch])
    case failure(HTTPError)
}

extension SearchPlayerModulePresenterState {
    var token: Cancellable? {
        switch self {
        case .loading(let token):
            return token
        case .failure, .success, .none:
            return nil
        }
    }
}
