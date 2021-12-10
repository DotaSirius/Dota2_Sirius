import Foundation

final class PlayersModule {
    let output: PlayersModuleOutput
    let input: PlayersModuleInput
    let viewControler: PlayersModuleViewController
    
    init(output: PlayersModuleOutput, networkService: NetworkService) {
        self.output = output
        let presenter = PlayersModulePresenter(networkService: networkService)
        presenter.view = viewControler
        input = presenter
        viewControler = PlayersModuleViewController(output: presenter)
    }
}
