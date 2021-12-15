import Foundation

final class SearchPlayerModuleBuilder {
    let viewController: SearchPlayerModuleViewController
    private let presenter: SearchPlayerModulePresenter
    var output: SearchPlayerModuleOutput {
        presenter.output
    }

    var input: SearchPlayerModuleInput {
        presenter
    }

    init(
        output: SearchPlayerModuleOutput,
        playerSearchService: PlayerSearchService,
        imageNetworkService: ImageNetworkService
    ) {
        presenter = SearchPlayerModulePresenter(output: output,
                                                playerSearchService: playerSearchService,
                                                imageNetworkService: imageNetworkService)
        viewController = SearchPlayerModuleViewController(output: presenter)
        presenter.view = viewController
    }
}
