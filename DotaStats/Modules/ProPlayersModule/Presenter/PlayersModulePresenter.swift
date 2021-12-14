import Foundation

protocol ProPlayersModuleInput: AnyObject {}

protocol ProPlayersModuleOutput: AnyObject {
    func playersModule(_ module: ProPlayersModuleInput, didSelectPlayer playerId: Int)
}

final class ProPlayersModulePresenter {
    weak var view: ProPlayersModuleViewInput?
    private let networkService: NetworkService
    let output: ProPlayersModuleOutput

    required init(networkService: NetworkService,
                  output: ProPlayersModuleOutput)
    {
        self.networkService = networkService
        self.output = output
    }
}

// MARK: - PlayersModuleInput

extension ProPlayersModulePresenter: ProPlayersModuleInput {}

// MARK: - PlayersModuleViewOutput

extension ProPlayersModulePresenter: ProPlayersModuleViewOutput {
    func playerSelected(_ player: Player) {
        // TODO:
    }
}

struct Player {
    
}
