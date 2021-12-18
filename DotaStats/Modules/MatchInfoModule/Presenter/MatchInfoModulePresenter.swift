import Foundation

protocol MatchInfoModuleInput: AnyObject {
    func setMatchId(_ id: Int)
}

protocol MatchInfoModuleOutput: AnyObject {
    func matchInfoModule(_ module: MatchInfoModulePresenter, didSelectPlayer playerId: Int)
}

final class MatchInfoModulePresenter {
    weak var view: MatchInfoModuleViewInput?

    private var pickedDisplayingMode = PickedDisplayingMode.overview

    let output: MatchInfoModuleOutput
    private let converter: MatchInfoConverter
    private var convertedData: [MatchTableViewCellType] = []
    private var rawMatchInfo: MatchDetail!
    private var convertedMatchInfo: [MatchTableViewCellType]?
    private var matchId: Int
    private let networkService: MatchDetailService
    private let regionsService: RegionsService
    private var regions: [String: String] = [:]
    private var heroes: [Hero] = []
    private let heroesService: HeroesService

    private var state: MatchesInfoModuleViewState {
        didSet {
            switch state {
            case .success:
                convertedData = [
                    MatchTableViewCellType.mainMatchInfo(
                        converter.mainMatchInfo(from: rawMatchInfo)
                    ),
                    MatchTableViewCellType.additionalMatchInfo(
                        converter.additionalMatchInfo(from: rawMatchInfo, regions: regions)
                    ),
                    MatchTableViewCellType.preferredDataViewModePicker(
                        pickedDisplayingMode
                    ),
                    MatchTableViewCellType.teamMatchInfo(
                        converter.radiantMatchInfo(from: rawMatchInfo)
                    ),
                    MatchTableViewCellType.matchPlayerHeaderInfo
                ]
                for index in 0..<5 {
                    convertedData.append(
                        MatchTableViewCellType.matchPlayerInfo(
                            converter.playerInfo(
                                from: rawMatchInfo,
                                playerNumber: index,
                                ranks: ConstanceStorage.instance.ranks
                            )
                        )
                    )
                }
                convertedData.append(
                    MatchTableViewCellType.teamMatchInfo(
                        converter.direMatchInfo(from: rawMatchInfo)
                    )
                )
                for index in 5..<10 {
                    convertedData.append(
                        MatchTableViewCellType.matchPlayerInfo(
                            converter.playerInfo(
                                from: rawMatchInfo,
                                playerNumber: index,
                                ranks: ConstanceStorage.instance.ranks
                            )
                        )
                    )
                }
                convertedData.append(
                    MatchTableViewCellType.wardsMapInfo(converter.wardsMapInfo(from: rawMatchInfo)))
                view?.update(state: .success)
            case .error:
                view?.update(state: .error)
            case .loading:
                view?.update(state: .loading)
            case .update:
                view?.update(state: .update)
            }
        }
    }

    required init(
        converter: MatchInfoConverter,
        output: MatchInfoModuleOutput,
        networkService: MatchDetailService,
        regionsService: RegionsService,
        heroesService: HeroesService
    ) {
        self.converter = converter
        self.output = output
        self.networkService = networkService
        self.regionsService = regionsService
        self.heroesService = heroesService
        state = .loading
        matchId = 1
    }

    private func requestData() {
        state = .loading

        if let regionsData = ConstanceStorage.instance.regionsData {
            regions = regionsData
        } else {
            regionsService.requestRegionsDetails { [weak self] result in
                guard
                    let self = self
                else {
                    return
                }
                switch result {
                case .success(let regions):
                    self.regions = regions
                case .failure: break
                }
            }
        }

        heroesService.requestHeroes { [weak self] result in
            guard
                let self = self
            else {
                return
            }
            switch result {
            case .success(let heroes):
                self.heroes = heroes
            case .failure: break
            }
        }

        networkService.requestMatchDetail(id: matchId) { [weak self] result in
            guard
                let self = self
            else {
                return
            }
            switch result {
            case .success(let rawMatchInfo):
                self.rawMatchInfo = rawMatchInfo
                self.state = .success

            case .failure:
                self.state = .error
            }
        }
    }

    private func showOverviewData() {
        clearDisplayingData()

        pickedDisplayingMode = PickedDisplayingMode.overview

        convertedData = [
            MatchTableViewCellType.mainMatchInfo(
                converter.mainMatchInfo(from: rawMatchInfo)
            ),
            MatchTableViewCellType.additionalMatchInfo(
                converter.additionalMatchInfo(from: rawMatchInfo, regions: regions)
            ),
            MatchTableViewCellType.preferredDataViewModePicker(
                pickedDisplayingMode
            ),
            MatchTableViewCellType.teamMatchInfo(
                converter.radiantMatchInfo(from: rawMatchInfo)
            ),
            MatchTableViewCellType.matchPlayerHeaderInfo
        ]
        for index in 0..<5 {
            convertedData.append(
                MatchTableViewCellType.matchPlayerInfo(
                    converter.playerInfo(
                        from: rawMatchInfo,
                        playerNumber: index,
                        ranks: ConstanceStorage.instance.ranks
                    )
                )
            )
        }
        convertedData.append(
            MatchTableViewCellType.teamMatchInfo(
                converter.direMatchInfo(from: rawMatchInfo)
            )
        )
        for index in 5..<10 {
            convertedData.append(
                MatchTableViewCellType.matchPlayerInfo(
                    converter.playerInfo(
                        from: rawMatchInfo,
                        playerNumber: index,
                        ranks: ConstanceStorage.instance.ranks
                    )
                )
            )
        }
        convertedData.append(
            MatchTableViewCellType.wardsMapInfo(converter.wardsMapInfo(from: rawMatchInfo)))
        convertedData.append(
            MatchTableViewCellType.plotGpmInfo(
                converter.plotInfo(from: rawMatchInfo, heroes: heroes)))
        view?.update(state: .update)
    }

    private func showGraphsData() {
        clearDisplayingData()

        pickedDisplayingMode = PickedDisplayingMode.graph

        convertedData = [
            MatchTableViewCellType.mainMatchInfo(
                converter.mainMatchInfo(from: rawMatchInfo)
            ),
            MatchTableViewCellType.additionalMatchInfo(
                converter.additionalMatchInfo(from: rawMatchInfo, regions: regions)
            ),
            MatchTableViewCellType.preferredDataViewModePicker(
                pickedDisplayingMode
            )
        ]

        convertedData.append(
            MatchTableViewCellType.plotGpmInfo(
                converter.plotInfo(from: rawMatchInfo, heroes: heroes)))

        view?.update(state: .update)
    }

    private func showVisionData() {
        clearDisplayingData()

        pickedDisplayingMode = PickedDisplayingMode.vision

        convertedData = [
            MatchTableViewCellType.mainMatchInfo(
                converter.mainMatchInfo(from: rawMatchInfo)
            ),
            MatchTableViewCellType.additionalMatchInfo(
                converter.additionalMatchInfo(from: rawMatchInfo, regions: regions)
            ),
            MatchTableViewCellType.preferredDataViewModePicker(
                pickedDisplayingMode
            )
        ]

        convertedData.append(
            MatchTableViewCellType.wardsMapInfo(converter.wardsMapInfo(from: rawMatchInfo)))
        convertedData.append(
            MatchTableViewCellType.plotGpmInfo(
                converter.plotInfo(from: rawMatchInfo, heroes: heroes)))
        view?.update(state: .update)
    }

    private func clearDisplayingData() {
        convertedData.removeAll()

        view?.update(state: .update)
    }
}

// MARK: - MatchInfoModuleInput

extension MatchInfoModulePresenter: MatchInfoModuleInput {
    func setMatchId(_ id: Int) {
        matchId = id
        requestData()
    }
}

// MARK: - MatchInfoModuleViewOutput

extension MatchInfoModulePresenter: MatchInfoModuleViewOutput {
    func matchTapped(indexPath: IndexPath) {
        switch convertedData[indexPath.row] {
        case .matchPlayerInfo(let player):
            output.matchInfoModule(self, didSelectPlayer: player.playerId)
        default:
            break
        }
    }

    func getSectionCount() -> Int {
        1
    }

    func getRowsCountInSection(_ section: Int) -> Int {
        convertedData.count
    }

    func getCellData(for row: Int) -> MatchTableViewCellData {
        MatchTableViewCellData(type: convertedData[row])
    }

    func pickSection(_ pickedSection: Int) {
        switch pickedSection {
        case 0:
            showOverviewData()
        case 1:
            showGraphsData()
        case 2:
            showVisionData()
        default:
            showOverviewData()
        }
    }
}
