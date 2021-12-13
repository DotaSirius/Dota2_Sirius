import Foundation

protocol PlayersModuleInput: AnyObject {
}

protocol PlayersModuleOutput: AnyObject {
    func playersModule(_ module: PlayersModuleInput, didSelectPlayer playerId: Int)
}

final class PlayersModulePresenter {
    weak var view: PlayersModuleViewInput?
    private let networkService: NetworkService
    let output: PlayersModuleOutput
    
    required init(networkService: NetworkService,
                  output: PlayersModuleOutput) {
        self.networkService = networkService
        self.output = output
    }
}

// MARK: - PlayersModuleInput

extension PlayersModulePresenter: PlayersModuleInput {
}

// MARK: - PlayersModuleViewOutput

extension PlayersModulePresenter: PlayersModuleViewOutput{
    func playerSelected(_ player: Player) {
        // TODO
    }
}
