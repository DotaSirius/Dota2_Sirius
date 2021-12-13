import Foundation

struct TournamentViewState {
    var leagueName: String
    struct MatchViewState {
        var radiantTeam: String
        var radiant: Bool
        var score: String // "radiantScore:direScore"
        var direTeam: String
        var id: Int
    }
}
