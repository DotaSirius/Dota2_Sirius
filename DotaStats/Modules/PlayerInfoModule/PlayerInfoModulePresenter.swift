import Foundation

protocol PlayerInfoModuleInput: AnyObject {}

protocol PlayerInfoModuleOutput: AnyObject {}

final class PlayerInfoModulePresenter {
    weak var view: PlayerInfoModuleViewInput? {
        didSet {
            updateView()
        }
    }

    private let playerInfoService: PlayerInfoService
    let output: PlayerInfoModuleOutput
    let playerId: Int
    var mainInfo: PlayerMainInfo?
    
    required init(playerInfoService: PlayerInfoService,
                  output: PlayerInfoModuleOutput,
                  playerId: Int) {
        self.playerInfoService = playerInfoService
        self.output = output
        self.state = .none
        self.playerId = playerId
        
        _ = playerInfoService.requestPlayerMainInfo(id: playerId) { [weak self] result in
            switch result {
            case .success(let player):
                self?.state = .success(player)
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }
    
    private var state: PlayerInfoModulePresenterState {
        didSet {
            switch state {
            case .success(let player):
                mainInfo = player
                view?.update(state: .success)
            case .error(let error):
                view?.update(state: .error(error.localizedDescription))
            case .loading:
                view?.update(state: .loading)
            case .none:
                break
            }
        }
    }
    
    private func updateView() { }
}

extension  PlayerInfoModulePresenter: PlayerInfoModuleInput {
    
}
