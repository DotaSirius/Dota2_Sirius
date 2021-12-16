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
    var playerMainInfo = PlayerMainInfoView()
    var playerWL = PlayerWLView()

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
            case .successMain(let player):
                playerMainInfo = convert(playerMainInfo: player)
                view?.update(state: .successMain)
            case .successWL(let player):
                playerWL = convert(playerWL: player)
                view?.update(state: .successWL)
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
                self?.state = .successMain(player)
            case .failure(let error):
                self?.state = .error(error)
            }
        }

        _ = playerInfoService.requestPlayerWLInfo(id: playerId) { [weak self] result in
            switch result {
            case .success(let player):
                self?.state = .successWL(player)
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }

    private func convert(playerMainInfo: PlayerMainInfo) -> PlayerMainInfoView {
        PlayerMainInfoView(
            name: playerMainInfo.profile.name ?? NSLocalizedString("", comment: ""),
            avatar: playerMainInfo.profile.avatarfull,
            leaderboardRank: playerMainInfo.leaderboardRank ?? 0
        )
    }

    private func convert(playerWL: PlayerWL) -> PlayerWLView {
        PlayerWLView(
            win: playerWL.win,
            lose: playerWL.lose
        )
    }
}

extension PlayerInfoModulePresenter: PlayerInfoModuleInput {

}

extension PlayerInfoModulePresenter: PlayerInfoModuleViewOutput {
    func getCellData(forSection: Int) -> PlayerTableViewCellData {
        switch forSection {
        case 0:
            return PlayerTableViewCellData.playerMainInfo(playerMainInfo)
        case 1:
            return PlayerTableViewCellData.playerWL(playerWL)
        case 2:
            return PlayerTableViewCellData.playerMatch
        default:
            return PlayerTableViewCellData.playerMainInfo(playerMainInfo)
        }
    }

    func getRowsInSection(section: Int) -> Int {
        switch section {
        case 0:
            return 2
        default:
            return 0
        }
    }
}
