import Foundation

struct MatchEvent {
    typealias Coordinates = (x: Int, y: Int)

    let eventType: MatchEventType?
    let involvedPlayers: [MatchDetail.Player]
    let coordinates: Coordinates?
}
