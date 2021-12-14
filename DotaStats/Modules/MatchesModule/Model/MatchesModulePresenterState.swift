import Foundation

enum MatchesModulePresenterState {
    case none
    case loading
    case success([Match])
    case error(HTTPError)
}
