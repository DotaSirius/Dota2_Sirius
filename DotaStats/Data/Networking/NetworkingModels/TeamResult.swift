import Foundation

struct TeamResult: Decodable {
    let teamId: Int
    let rating: Double
    let wins: Int
    let losses: Int
    let lastMatchTime: Date
    let name: String
    let tag: String?
    let logoUrl: String
}
