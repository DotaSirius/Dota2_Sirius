import Foundation

final class ProPlayersModuleBuilder {
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
//        viewController = ProPlayersModuleViewController(output: presenter)
        viewController = ProPlayersModuleViewController()
        presenter.view = viewController
    }
}
