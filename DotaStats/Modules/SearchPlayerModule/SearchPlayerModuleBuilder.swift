import Foundation

final class SearchPlayerModuleBuilder {
    let viewControler: SearchPlayerModuleViewController
    private let presenter: SearchPlayerModulePresenter
    var output: SearchPlayerModuleOutput {
        presenter.output
    }

    var input: SearchPlayerModuleInput {
        presenter
    }

    init(output: SearchPlayerModuleOutput,
         playerSearchNetworkService: PlayerSearchNetworkService,
         imageNetworkService: ImageNetworkService)
    {
        presenter = SearchPlayerModulePresenter(output: output,
                                                playerNetworkService: playerSearchNetworkService,
                                                imageNetworkService: imageNetworkService)
        viewControler = SearchPlayerModuleViewController(output: presenter)
        presenter.view = viewControler
    }
}
