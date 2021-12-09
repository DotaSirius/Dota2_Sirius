import Foundation

protocol PlayersModuleInput: AnyObject {
    func showLoading()
    func showPlayers(_ players: [Player])
}

protocol PlayersModuleOutput: AnyObject {
    var view: PlayersModuleInput? { get set }
    init(networkService: NetworkSeviceProtocol)
    func players() -> [Player]
    func playerByName(_ name: String) -> [Player]
    func didSelectPlayer(_ player: Player)
}

class PlayersModulePresenter: PlayersModuleOutput {
    weak var view: PlayersModuleInput?
    
    required init(networkService: NetworkSeviceProtocol) {
        <#code#>
    }
    
    func players() -> [Player] {
        <#code#>
    }
    
    func playerByName(_ name: String) -> [Player] {
        <#code#>
    }
    
    func didSelectPlayer(_ player: Player) {
        <#code#>
    }
}
