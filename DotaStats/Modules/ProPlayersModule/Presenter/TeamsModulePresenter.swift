import Foundation

protocol TeamsModuleInput: AnyObject {}

protocol TeamsModuleOutput: AnyObject {
    func playersModule(_ module: TeamsModuleInput, didSelectPlayer playerId: Int)
}

final class TeamsModulePresenter {
    weak var view: TeamsModuleViewInput?
    private let networkService: NetworkService
    let output: TeamsModuleOutput

    required init(networkService: NetworkService,
                  output: TeamsModuleOutput)
    {
        self.networkService = networkService
        self.output = output
    }
}

// MARK: - TeamsModuleInput

extension TeamsModulePresenter: TeamsModuleInput {}

// MARK: - TeamsModuleViewOutput

extension TeamsModulePresenter: TeamsModuleViewOutput {
    func playerSelected(_ player: Player) {
        // TODO:
    }
}

struct Player {
    
}
