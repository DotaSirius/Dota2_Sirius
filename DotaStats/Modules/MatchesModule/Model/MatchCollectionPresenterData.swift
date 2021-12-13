import Foundation

struct MatchCollectionPresenterData {
    var isOpen: Bool
    var tournamentNumber: Int
    var tournament: TournamentViewState
    var matches: [TournamentViewState.MatchViewState]
}
