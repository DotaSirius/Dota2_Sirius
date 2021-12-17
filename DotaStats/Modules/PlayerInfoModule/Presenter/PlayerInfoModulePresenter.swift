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
    private let constantsService: GithubConstantsService
    private var heroImages: [String: String] = [:]
    private var gameModes: [String: String] = [:]
    private let playerId: Int
    private var playerMainInfo = PlayerMainInfoViewState()
    private var playerWL = PlayerWLViewState()
    private var playerMatch: [PlayerMatchViewState] = []

    required init(playerInfoService: PlayerInfoService,
                  constantsService: GithubConstantsService,
                  output: PlayerInfoModuleOutput,
                  playerId: Int) {
        self.playerInfoService = playerInfoService
        self.constantsService = constantsService
        self.output = output
        state = .none
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
        loadGameModeData()
        loadHeroImages()

        playerInfoService.requestPlayerMainInfo(id: playerId) { [weak self] result in
            switch result {
            case .success(let player):
                self?.state = .successMain(player)
            case .failure(let error):
                self?.state = .error(error)
            }
        }

        playerInfoService.requestPlayerWLInfo(id: playerId) { [weak self] result in
            switch result {
            case .success(let player):
                self?.state = .successWL(player)
            case .failure(let error):
                self?.state = .error(error)
            }
        }

        playerInfoService.requestPlayerMatchesInfo(id: playerId) { [weak self] result in
            switch result {
            case .success(let player):
                self?.state = .successMatch(player)
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }

    private func loadGameModeData() {
        if let gameModesData = ConstanceStorage.instance.gameModes {
            gameModes = self.convert(gameModes: gameModesData)
        } else {
            constantsService.requestGameModes { [weak self] result in
                guard
                    let self = self
                else {
                    return
                }
                switch result {
                case .success(let gameModesData):
                    self.gameModes = self.convert(gameModes: gameModesData)
                case .failure: break
                }
            }
        }
    }

    private func loadHeroImages() {
        if let heroImagesData = ConstanceStorage.instance.heroImages {
            heroImages = self.convert(heroImages: heroImagesData)
        } else {
            constantsService.requestImagesHero { [weak self] result in
                guard
                    let self = self
                else {
                    return
                }
                switch result {
                case .success(let heroImagesData):
                    self.heroImages = self.convert(heroImages: heroImagesData)
                case .failure: break
                }
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
            heroImage:
                heroImages[String(playerMatch.heroId ?? 0)] ??
                NSLocalizedString(
                    "https://offers-api.agregatoreat.ru/api/file/649bf689-2165-46b1-8e5c-0ec89a54c05f",
                    comment: "No image"
                ),
            kills: playerMatch.kills ?? 0,
            deaths: playerMatch.deaths ?? 0,
            assists: playerMatch.assists ?? 0,
            skill: skill,
            gameMode: gameModes[String(playerMatch.gameMode ?? 0)] ?? "Game mode unknown"
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

    private func convert(heroImages: [String: HeroImage]) -> [String: String] {
        var heroImagesConverted: [String: String] = [:]
        for (index, image) in heroImages {
            heroImagesConverted[index] =
            NSLocalizedString("https://api.opendota.com", comment: "URL of opendota API") + (image.img ?? "")
        }
        return heroImagesConverted
    }

    private func convert(gameModes: [String: GameMode]) -> [String: String] {
        var gameModesConverted: [String: String] = [:]
        for (index, gameMode) in gameModes {
            let parsedMode = gameMode.name?.components(separatedBy: "_").dropFirst().dropFirst() ?? []
            let finalMode = parsedMode.joined(separator: " ")
            gameModesConverted[index] = finalMode
        }
        return gameModesConverted
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
