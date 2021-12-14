import Foundation

struct PlayerInfo {
    let name: String
    let leaderboardRank: Int
    let avatar: String
    let win: Int
    let lose: Int
    let recentMatches: [PlayerMatch]
}

struct PlayerMainInfo: Decodable {
    let trackedUntil: String
    let soloCompetitiveRank: String
    let competitiveRank: String
    let rankTier: Int
    let leaderboardRank: Int
    let mmrEstimate: MmrEstimate
    let profile: Profile
}

struct MmrEstimate: Decodable {
    let estimate: Int
}

struct Profile: Decodable {
    let accountid: Int
    let personaname: String
    let name: String
    let plus: Bool
    let cheese: Int
    let steamid: String
    let avatar: String
    let avatarmedium: String
    let avatarfull: String
    let profileurl: String
    let lastLogin: String
    let loccountrycode: String
    let isContributor: Bool
}

struct PlayerWL: Decodable {
    let win: Int
    let lose: Int
}

struct PlayerMatch: Decodable {
    let matchId: Int
    let playerSlot: Int
    let radiantWin: Bool
    let duration: Int
    let gameMode: Int
    let lobbyType: Int
    let heroId: Int
    let startTime: Int
    let version: Int
    let kills: Int
    let deaths: Int
    let assists: Int
    let skill: Int
    let leaverStatus: Int
    let partySize: Int
}
