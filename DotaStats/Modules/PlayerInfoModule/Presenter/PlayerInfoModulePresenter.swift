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
    var playerMatch: [PlayerMatchView] = []

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

    private func convert(playerMatch: PlayerMatch) -> PlayerMatchView {
        let radiantWin = playerMatch.radiantWin ?? false
        let isRadiant = playerMatch.playerSlot ?? 0 < 128
        var skill = ""
        if (playerMatch.skill == 1) {
            skill = "Normal skill"
        } else if (playerMatch.skill == 2) {
            skill = "High skill"
        } else if (playerMatch.skill == 3) {
            skill = "Very High skill"
        } else {
            skill = "Unknown skill"
        }

        return PlayerMatchView(
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
}

extension PlayerInfoModulePresenter: PlayerInfoModuleInput {

}

extension PlayerInfoModulePresenter: PlayerInfoModuleViewOutput {
    func getCellData(forRow: Int) -> PlayerTableViewCellData {
        if (forRow == 0) {
            return PlayerTableViewCellData.playerMainInfo(playerMainInfo)
        } else if (forRow == 1) {
            return PlayerTableViewCellData.playerWL(playerWL)
        } else if (forRow == 2) {
            return PlayerTableViewCellData.recentMatchesTitle
        } else if (forRow == 3) {
            return PlayerTableViewCellData.recentMatchesHeader
        } else {
            return PlayerTableViewCellData.playerMatch(playerMatch[forRow - 4])
        }
    }

    func getRowsInSection(section: Int) -> Int {
        switch section {
        case 0:
            return 3 + playerMatch.count
        default:
            return 0
        }
    }
}
