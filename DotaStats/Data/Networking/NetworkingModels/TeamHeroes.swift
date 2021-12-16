import Foundation

struct TeamHeroes: Decodable {
    let heroId: Int?
    let localizedName: String?
    let gamesPlayed: Int?
    let duration: Int?
    let wins: Int?
}
