import Foundation

enum PlotGmpModulePresenterState {
    case none
    case loading
    case success(MatchDetail)
    case error(HTTPError)
}
