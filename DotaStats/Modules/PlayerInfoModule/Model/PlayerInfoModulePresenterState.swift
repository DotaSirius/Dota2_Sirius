import Foundation

enum PlayerInfoModulePresenterState {
    case none
    case loading
    case successMain(PlayerMainInfo)
    case successWL(PlayerWL)
    case successMatch([PlayerMatch])
    case error(HTTPError)
}
