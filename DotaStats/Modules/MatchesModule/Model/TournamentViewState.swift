import Foundation

struct TournamentViewState {
    var leagueName: String
    struct MatchViewState {
        var radiantTeam: String
        var radiant: Bool
        var direTeam: String
        var id: Int
        var radiantScore: Int
        var direScore: Int
        var score: String {
            "\(radiantScore):\(direScore)"
        }
    }
}
