import Foundation

protocol PlayerSearchNetworkService: AnyObject {
    func playersByName(_ name: String, completion: @escaping (Result<[Players], HTTPError>) -> Void) -> Cancellable?
}

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
        []
    }
    
    func playersByName(_ name: String) -> [Player] {
        // TODO
        []
    }
    
    func proMatches() -> [Match] {
        // TODO
        []
    }
    
    func matchById(_ id: Int) -> Match {
        // TODO
        Match()
    }
    
    func playerInfoById(_ id: Int) -> PlayerInfo {
        // TODO
        PlayerInfo()
    }
    
    func matchInfoById(_ id: Int) -> MatchInfo {
        // TODO
        MatchInfo()
    }
}
