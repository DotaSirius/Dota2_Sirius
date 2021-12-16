import Foundation

struct TeamResult: Decodable {
    let teamId: Int
    let rating: Float
    let wins: Int
    let losses: Int
    let lastMatchTime: Date
    let name: String
    let tag: String
    let logoUrl: String?
}
