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
        converter: MatchInfoConverter
    ) {
        self.presenter = MatchInfoModulePresenter(
            converter: converter,
            output: output,
            networkService: networkService,
            regionsService: regionsService
        )
        self.viewController = MatchInfoViewController(output: presenter)
        self.presenter.view = viewController
    }
}
