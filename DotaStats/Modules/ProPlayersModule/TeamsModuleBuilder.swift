import Foundation

final class ProPlayersModuleBuilder {
    let viewController: TeamsModuleViewController
    private let presenter: TeamsModulePresenter
    var output: TeamsModuleOutput {
        presenter.output
    }

    var input: TeamsModuleInput {
        presenter
    }

    init(output: TeamsModuleOutput, networkService: NetworkService) {
        presenter = TeamsModulePresenter(networkService: networkService, output: output)
//        viewController = ProPlayersModuleViewController(output: presenter)
        viewController = TeamsModuleViewController()
        presenter.view = viewController
    }
}
