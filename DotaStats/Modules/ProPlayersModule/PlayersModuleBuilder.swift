import Foundation

final class PlayersModuleBuilder {
    let viewController: ProPlayersModuleViewController
    private let presenter: ProPlayersModulePresenter
    var output: ProPlayersModuleOutput {
        presenter.output
    }

    var input: ProPlayersModuleInput {
        presenter
    }

    init(output: ProPlayersModuleOutput, networkService: NetworkService) {
        presenter = ProPlayersModulePresenter(networkService: networkService, output: output)
        viewController = ProPlayersModuleViewController(output: presenter)
        presenter.view = viewController
    }
}
