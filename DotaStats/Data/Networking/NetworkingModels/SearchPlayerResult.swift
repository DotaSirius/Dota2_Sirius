import Foundation

struct SearchPlayerResult: Decodable {
    let accountId: Int
    let avatarfull: String?
    let personaname: String?
    let lastMatchTime: Date?
    let similarity: Double?
}
