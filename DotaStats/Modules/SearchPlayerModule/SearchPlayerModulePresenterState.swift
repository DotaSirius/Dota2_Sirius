import Foundation

enum SearchPlayerModulePresenterState {
    case none
    case loading(Cancellable?)
    case result(Result<[Players], HTTPError>)
}

extension SearchPlayerModulePresenterState {

    var token: Cancellable? {
        switch self {
        case .loading(let token):
            return token
        case .result, .none:
            return nil
        }
    }
}
