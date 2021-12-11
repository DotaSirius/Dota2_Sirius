import Foundation

enum MatchCellType {
    case tournamentViewState (TournamentViewState)
    case matchViewState (TournamentViewState.MatchViewState)
}

extension MatchCellType {
    var reuseIdentifier: String {
        switch self {
        case .tournamentViewState:
            return ""
        case .matchViewState:
            return ""
        }
    }
}
