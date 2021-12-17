import Foundation

final class PlotGmpModuleBuilder {
    let viewControler: PlotGmpViewController
    private let presenter:  PlotGmpModulePresenter
    var output:  PlotGmpModuleOutput {
        presenter.output
    }
    var input:  PlotGmpModuleInput {
        presenter
    }

    init(output: PlotGmpModuleOutput, plotService: MatchDetailService) {
        self.presenter = PlotGmpModulePresenter(output: output, networkService: plotService)
        self.viewControler = PlotGmpViewController(output: presenter)
        self.presenter.view = viewControler
    }
}
