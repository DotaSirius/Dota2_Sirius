import Foundation

struct PlayerMainInfo: Decodable {
    let trackedUntil: String?
    let soloCompetitiveRank: Int?
    let competitiveRank: Int?
    let rankTier: Int?
    let leaderboardRank: Int?
    let mmrEstimate: Estimate
    let profile: Profile

    struct Estimate: Decodable {
        let estimate: Int?
    }

    struct Profile: Decodable {
        let accountId: Int?
        let personaname: String?
        let name: String?
        let plus: Bool?
        let cheese: Int?
        let steamid: String?
        let avatar: String?
        let avatarmedium: String?
        let avatarfull: String?
        let profileurl: String?
        let lastLogin: String?
        let loccountrycode: String?
        let isContributor: Bool?
    }
}
