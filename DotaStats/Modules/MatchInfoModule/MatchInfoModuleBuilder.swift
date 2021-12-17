import Foundation

final class MatchInfoModuleBuilder {
    let viewController: MatchInfoViewController
    private let presenter:  MatchInfoModulePresenter
    var output:  MatchInfoModuleOutput {
        presenter.output
    }
    var input:  MatchInfoModuleInput {
        presenter
    }

    init(
        output: MatchInfoModuleOutput,
        networkService: MatchDetailService,
        regionsService: RegionsService,
        heroImagesService: GithubConstantsService,
        converter: MatchInfoConverter
    ) {
        self.presenter = MatchInfoModulePresenter(
            converter: converter,
            output: output,
            networkService: networkService,
            regionsService: regionsService,
            heroImagesService: heroImagesService
        )
        self.viewController = MatchInfoViewController(output: presenter)
        self.presenter.view = viewController
    }
}
