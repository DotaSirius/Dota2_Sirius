import Foundation

struct TeamPlayers: Decodable {
    let accountId: Int?
    let name: String?
    let gamesPlayed: Int?
    let wins: Int?
    let isCurrentTeamMember: Bool?
}
