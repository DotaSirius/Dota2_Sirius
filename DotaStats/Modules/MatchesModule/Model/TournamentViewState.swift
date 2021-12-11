import Foundation

struct TournamentViewState {
    var leagueName: String
    struct MatchViewState {
        var radiantTeam: String
        var radiant: Bool
        var radiantScore: Int
        var direScore: Int
        var direTeam: String
        var duration: String // "40:15"
    }
}
