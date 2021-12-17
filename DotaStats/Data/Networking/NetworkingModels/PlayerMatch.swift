import Foundation

struct PlayerMatch: Decodable {
    let matchId: Int
    let playerSlot: Int?
    let radiantWin: Bool?
    let duration: Int?
    let gameMode: Int?
    let lobbyType: Int?
    let heroId: Int?
    let startTime: Int?
    let version: Int?
    let kills: Int?
    let deaths: Int?
    let assists: Int?
    let skill: Int?
    let leaverStatus: Int?
    let partySize: Int?
}
