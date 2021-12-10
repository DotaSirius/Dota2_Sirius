import Foundation

protocol NetworkService: AnyObject {
    func proPlayers() -> [Player]
    func playersByName(_ name: String) -> [Player]
    func proMatches() -> [Match]
    func matchById(_ id: Int) -> Match
    func playerInfoById(_ id: Int) -> PlayerInfo
    func matchInfoById(_ id: Int) -> MatchInfo
}

class NetworkServiceImp: NetworkService {
    func proPlayers() -> [Player] {
        <#code#>
    }
    
    func playersByName(_ name: String) -> [Player] {
        <#code#>
    }
    
    func proMatches() -> [Match] {
        <#code#>
    }
    
    func matchById(_ id: Int) -> Match {
        <#code#>
    }
    
    func playerInfoById(_ id: Int) -> PlayerInfo {
        <#code#>
    }
    
    func matchInfoById(_ id: Int) -> MatchInfo {
        <#code#>
    }
    
    
}
