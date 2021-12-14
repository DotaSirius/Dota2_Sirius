import Foundation

enum MatchesModulePresenterState {
    case none
    case loading(Cancellable?)
    case success([Match])
    case error(HTTPError)
}

extension MatchesModulePresenterState {
    var mathesRequestToken: Cancellable? {
        switch self {
        case .loading(let token):
            return token
        case .success, .error, .none:
            return nil
        }
    }
}
