import Foundation

struct ProPlayer : Decodable {
    let accountId : Int
    let steamid : String?
    let avatar : String?
    let avatarmedium: String?
    let avatarfull: String?
    let profileurl: String?
    let personaname: String?
    let lastLogin: Date?
    let fullHistoryTime: Date?
    let cheese: Int?
    let fhUnavailable: Bool?
    let loccountrycode: String?
    let name: String?
    let countryCode: String?
    let fantasyRole: Int?
    let teamId: Int?
    let teamName: String?
    let teamTag: String?
    let isLocked: Bool?
    let isPro: Bool
    let lockedUntil: Int?
}
