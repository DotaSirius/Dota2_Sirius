import Foundation

final class PlayersModuleBuilder {
    let viewController: PlayersModuleViewController
    private let presenter: PlayersModulePresenter
    var output: PlayersModuleOutput {
        presenter.output
    }

    var input: PlayersModuleInput {
        presenter
    }

    init(output: PlayersModuleOutput, networkService: NetworkService) {
        presenter = PlayersModulePresenter(networkService: networkService, output: output)
        viewController = PlayersModuleViewController(output: presenter)
        presenter.view = viewController
    }
}
