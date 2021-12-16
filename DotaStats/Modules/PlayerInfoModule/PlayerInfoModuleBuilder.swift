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

    init(output: PlayerInfoModuleOutput, playerInfoService: PlayerInfoService, playerId: Int) {
        presenter = PlayerInfoModulePresenter(
            playerInfoService: playerInfoService,
            output: output,
            playerId: playerId)
        viewController = PlayerInfoModuleViewController(output: presenter)
        presenter.view = viewController
    }
}
