import Foundation

protocol PlayerInfoModuleInput: AnyObject {}

protocol PlayerInfoModuleOutput: AnyObject {}

final class PlayerInfoModulePresenter {
    weak var view: PlayerInfoModuleViewInput? {
        didSet {
            updateView()
        }
    }

    let output: PlayerInfoModuleOutput
    private let playerInfoService: PlayerInfoService
    private let playerId: Int
    private var playerMainInfo = PlayerMainInfoViewState()
    private var playerWL = PlayerWLViewState()
    private var playerMatch: [PlayerMatchViewState] = []

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
            case .successMatch(let player):
                playerMatch += player.map { convert(playerMatch: $0) }
                view?.update(state: .successMatch)
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

        _ = playerInfoService.requestPlayerMatchesInfo(id: playerId) { [weak self] result in
            switch result {
            case .success(let player):
                self?.state = .successMatch(player)
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }

    private func convert(playerMainInfo: PlayerMainInfo) -> PlayerMainInfoViewState {
        PlayerMainInfoViewState(
            name: playerMainInfo.profile.name ?? NSLocalizedString("", comment: ""),
            avatarUrl: playerMainInfo.profile.avatarfull,
            leaderboardRank: playerMainInfo.leaderboardRank ?? 0
        )
    }

    private func convert(playerWL: PlayerWL) -> PlayerWLViewState {
        PlayerWLViewState(
            win: playerWL.win,
            lose: playerWL.lose
        )
    }

    private func convert(playerMatch: PlayerMatch) -> PlayerMatchViewState {
        let radiantWin = playerMatch.radiantWin ?? false
        let isRadiant = playerMatch.playerSlot ?? 0 < 128
        let skill = convert(skill: playerMatch.skill)

        return PlayerMatchViewState(
            matchId: playerMatch.matchId,
            win: isRadiant ? radiantWin : !radiantWin,
            duration: (playerMatch.duration ?? 0) / 60,
            heroId: playerMatch.heroId ?? 0,
            kills: playerMatch.kills ?? 0,
            deaths: playerMatch.deaths ?? 0,
            assists: playerMatch.assists ?? 0,
            skill: skill,
            gameMode: playerMatch.gameMode ?? 0
        )
    }

    private func convert(skill: Int?) -> String {
        switch skill {
        case 1:
            return NSLocalizedString("Normal skill", comment: "")
        case 2:
            return NSLocalizedString("High skill", comment: "")
        case 3:
            return NSLocalizedString("Very High skill", comment: "")
        default:
            return NSLocalizedString("Unknown skill", comment: "")
        }
    }
}

extension PlayerInfoModulePresenter: PlayerInfoModuleInput {

}

extension PlayerInfoModulePresenter: PlayerInfoModuleViewOutput {
    func getCellData(forIndexPath: IndexPath) -> PlayerTableViewCellData {
        switch forIndexPath.section {
        case 0:
            switch forIndexPath.row {
            case 0:
                return PlayerTableViewCellData.playerMainInfo(playerMainInfo)
            case 1:
                return PlayerTableViewCellData.playerWL(playerWL)
            case 2:
                return PlayerTableViewCellData.recentMatchesTitle
            default:
                return PlayerTableViewCellData.recentMatchesHeader
            }
        default:
            return PlayerTableViewCellData.playerMatch(playerMatch[forIndexPath.row])
        }
    }

    func getRowsInSection(section: Int) -> Int {
        switch section {
        case 0:
            return 4
        case 1:
            return playerMatch.count
        default:
            return 0
        }
    }
}
