import Foundation

enum MatchesModulePresenterState {
    case none
    case loading(Cancellable?)
    case result(Result<[Match], HTTPError>)
}

extension MatchesModulePresenterState {
    var token: Cancellable? {
        switch self {
        case .loading(let token):
            return token
        case .result, .none:
            return nil
        }
    }
}
