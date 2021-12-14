import Foundation

struct Match: Decodable, Comparable {
    let matchId: Int
    let duration: Int
    let startTime: Date
    let radiantTeamId: Int?
    let radiantName: String?
    let direTeamId: Int?
    let direName: String?
    let leagueid: Int
    let leagueName: String
    let seriesId: Int
    let seriesType: Int
    let radiantScore: Int
    let direScore: Int
    let radiantWin: Bool
    let radiant: Bool?

    static func < (lhs: Match, rhs: Match) -> Bool {
        return lhs.startTime < rhs.startTime
    }
}
