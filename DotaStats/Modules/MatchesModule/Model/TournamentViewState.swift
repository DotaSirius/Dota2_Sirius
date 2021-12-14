import Foundation

struct TournamentViewState {
    let leagueName: String
    var isOpen: Bool

    struct Match {
        let radiantTeam: String
        let radiant: Bool
        let direTeam: String
        let id: Int
        let radiantScore: Int
        let direScore: Int
        var score: String {
            "\(radiantScore):\(direScore)"
        }
    }
}
