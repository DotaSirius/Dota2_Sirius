import Foundation

enum PlayerInfoModulePresenterState {
    case none
    case loading
    case success(PlayerMainInfo)
    // case successMain(Players)
    // case successWL(PlayerWL)
    // case successMatches([PlayerMatch])

    case error(HTTPError)
}
