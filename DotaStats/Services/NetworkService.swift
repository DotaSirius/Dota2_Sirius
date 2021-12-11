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
        Match(matchId: "", startTime: 0, leagueName: "", radiantTeam: "", radiant: true, radiantScore: 0, direScore: 0, direTeam: "", duration: "")
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
