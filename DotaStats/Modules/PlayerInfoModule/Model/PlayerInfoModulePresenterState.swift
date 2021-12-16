import Foundation

enum PlayerInfoModulePresenterState {
    case none
    case loading
    case successMain(PlayerMainInfo)
    case successWL(PlayerWL)
    // case successMatches([PlayerMatch])
    case error(HTTPError)
}
