import Foundation

struct MatchCollectionPresenterData {
    var isOpen: Bool
    let tournament: TournamentViewState
    var matches: [TournamentViewState.MatchViewState]
}
