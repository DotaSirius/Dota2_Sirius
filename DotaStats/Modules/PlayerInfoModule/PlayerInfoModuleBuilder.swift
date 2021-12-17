import Foundation

final class PlayerInfoModuleBuilder {
    let viewController: PlayerInfoModuleViewController
    private let presenter: PlayerInfoModulePresenter
    var output: PlayerInfoModuleOutput {
        presenter.output
    }
    var input: PlayerInfoModuleInput {
        presenter
    }

    init(output: PlayerInfoModuleOutput,
         playerInfoService: PlayerInfoService,
         constantsService: GithubConstantsService,
         playerId: Int) {
        presenter = PlayerInfoModulePresenter(
            playerInfoService: playerInfoService,
            constantsService: constantsService,
            output: output,
            playerId: playerId
        )
        viewController = PlayerInfoModuleViewController(output: presenter)
        presenter.view = viewController
    }
}
