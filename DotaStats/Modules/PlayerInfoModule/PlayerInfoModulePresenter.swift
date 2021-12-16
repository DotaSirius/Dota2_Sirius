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
    var mainInfo = PlayerMainInfoView()
    
    required init(playerInfoService: PlayerInfoService,
                  output: PlayerInfoModuleOutput,
                  playerId: Int) {
        self.playerInfoService = playerInfoService
        self.output = output
        self.state = .none
        self.playerId = playerId
    }
    
    private var state: PlayerInfoModulePresenterState {
        didSet {
            switch state {
            case .success(let player):
                mainInfo = convert(playerMainInfo: player)
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
    
    private func updateView() {
        state = .loading
        _ = playerInfoService.requestPlayerMainInfo(id: playerId) { [weak self] result in
            switch result {
            case .success(let player):
                self?.state = .success(player)
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }
    
    private func convert(playerMainInfo: PlayerMainInfo) -> PlayerMainInfoView {
        PlayerMainInfoView(
            name: playerMainInfo.profile.name ?? NSLocalizedString("Player", comment: ""),
            avatar: playerMainInfo.profile.avatar,
            leaderboardRank: playerMainInfo.leaderboardRank ?? 0
        )
    }
}

extension PlayerInfoModulePresenter: PlayerInfoModuleInput {
    
}

extension PlayerInfoModulePresenter: PlayerInfoModuleViewOutput {
    func getMainData() -> PlayerMainInfoView {
        mainInfo
    }
}
