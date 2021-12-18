import Foundation

struct TeamMatches: Decodable {
    let matchId: Int?
    let radiantWin: Bool?
    let radiant: Bool?
    let duration: Int?
    let startTime: Int?
    let leagueid: Int?
    let leagueName: String?
    let cluster: Int?
    let opposingTeamId: Int?
    let opposingTeamName: String?
    let opposingTeamLogo: String?
}
