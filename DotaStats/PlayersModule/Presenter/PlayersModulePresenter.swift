import Foundation

protocol PlayersModuleInput: AnyObject {
    func show()
}

protocol PlayersModuleOutput: AnyObject {
    func playersModule(_ module: PlayersModuleInput, didSelectPlayer player: Player)
}

final class PlayersModulePresenter {
    weak var view: PlayersModuleViewInput?
    
    required init(networkService: NetworkService) {
        // TODO
    }
}

// MARK: - PlayersModuleInput
extension PlayersModulePresenter: PlayersModuleInput {
    func show() {
        // TODO
    }
}

// MARK: - PlayersModuleViewOutput
extension PlayersModulePresenter: PlayersModuleViewOutput{
    func players() -> [Player] {
        // TODO
        return [Player]()
    }
    
    func playersByName(_ name: String) -> [Player] {
        // TODO
        return [Player]()
    }
}
