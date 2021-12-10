import Foundation

protocol NetworkService: AnyObject {
    func proPlayers() -> [Player]
    func playersByName(_ name: String) -> [Player]
    func proMatches() -> [Match]
    func matchById(_ id: Int) -> Match
    func playerInfoById(_ id: Int) -> PlayerInfo
    func matchInfoById(_ id: Int) -> MatchInfo
}

final class NetworkServiceImp: NetworkService {
    func proPlayers() -> [Player] {
        // TODO
        return [Player]()
    }
    
    func playersByName(_ name: String) -> [Player] {
        // TODO
        return [Player]()
    }
    
    func proMatches() -> [Match] {
        // TODO
        return [Match]()
    }
    
    func matchById(_ id: Int) -> Match {
        // TODO
        return Match()
    }
    
    func playerInfoById(_ id: Int) -> PlayerInfo {
        // TODO
        return PlayerInfo()
    }
    
    func matchInfoById(_ id: Int) -> MatchInfo {
        // TODO
        return MatchInfo()
    }
}
