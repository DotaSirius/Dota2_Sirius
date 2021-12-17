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

    private var state: MatchesInfoModuleViewState {
        didSet {
            switch state {
            case .success:
                self.convertedData = [
                    MatchTableViewCellType.mainMatchInfo(
                            converter.mainMatchInfo(from: self.rawMatchInfo)
                    ),
                    MatchTableViewCellType.additionalMatchInfo(
                            converter.additionalMatchInfo(from: self.rawMatchInfo, regions: regions)
                    ),
                    MatchTableViewCellType.preferredDataViewModePicker(
                            pickedDisplayingMode
                    ),
                    MatchTableViewCellType.teamMatchInfo(
                            converter.radiantMatchInfo(from: self.rawMatchInfo)
                    ),
                    MatchTableViewCellType.matchPlayerHeaderInfo
                ]
                for index in 0..<5 {
                    self.convertedData.append(
                        MatchTableViewCellType.matchPlayerInfo(
                            converter.playerInfo(
                                from: self.rawMatchInfo,
                                playerNumber: index,
                                ranks: ConstanceStorage.instance.ranks
                            )
                        )
                    )
                }
                self.convertedData.append(
                        MatchTableViewCellType.teamMatchInfo(
                                converter.direMatchInfo(from: self.rawMatchInfo)
                        )
                )
                for index in 5..<10 {
                    self.convertedData.append(
                        MatchTableViewCellType.matchPlayerInfo(
                            converter.playerInfo(
                                from: self.rawMatchInfo,
                                playerNumber: index,
                                ranks: ConstanceStorage.instance.ranks
                            )
                        )
                    )
                }
                self.convertedData.append(
                        MatchTableViewCellType.wardsMapInfo(converter.wardsMapInfo(from: self.rawMatchInfo)))
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
            regionsService: RegionsService
    ) {
        self.converter = converter
        self.output = output
        self.networkService = networkService
        self.regionsService = regionsService
        self.state = .loading
        self.matchId = 1
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

        self.convertedData = [
            MatchTableViewCellType.mainMatchInfo(
                    converter.mainMatchInfo(from: self.rawMatchInfo)
            ),
            MatchTableViewCellType.additionalMatchInfo(
                    converter.additionalMatchInfo(from: self.rawMatchInfo, regions: regions)
            ),
            MatchTableViewCellType.preferredDataViewModePicker(
                    pickedDisplayingMode
            ),
            MatchTableViewCellType.teamMatchInfo(
                    converter.radiantMatchInfo(from: self.rawMatchInfo)
            ),
            MatchTableViewCellType.matchPlayerHeaderInfo
        ]
        for index in 0..<5 {
            self.convertedData.append(
                    MatchTableViewCellType.matchPlayerInfo(
                            converter.playerInfo(
                                    from: self.rawMatchInfo,
                                    playerNumber: index,
                                    ranks: ConstanceStorage.instance.ranks)
                    )
            )
        }
        self.convertedData.append(
                MatchTableViewCellType.teamMatchInfo(
                        converter.direMatchInfo(from: self.rawMatchInfo)
                )
        )
        for index in 5..<10 {
            self.convertedData.append(
                    MatchTableViewCellType.matchPlayerInfo(
                            converter.playerInfo(
                                    from: self.rawMatchInfo,
                                    playerNumber: index,
                                    ranks: ConstanceStorage.instance.ranks)
                    )
            )
        }
        self.convertedData.append(
                MatchTableViewCellType.wardsMapInfo(converter.wardsMapInfo(from: self.rawMatchInfo)))
        view?.update(state: .update)
    }

    private func showGraphsData() {
        clearDisplayingData()

        pickedDisplayingMode = PickedDisplayingMode.graph

        self.convertedData = [
            MatchTableViewCellType.mainMatchInfo(
                    converter.mainMatchInfo(from: self.rawMatchInfo)
            ),
            MatchTableViewCellType.additionalMatchInfo(
                    converter.additionalMatchInfo(from: self.rawMatchInfo, regions: regions)
            ),
            MatchTableViewCellType.preferredDataViewModePicker(
                    pickedDisplayingMode
            )
        ]

        view?.update(state: .update)
    }

    private func showVisionData() {
        clearDisplayingData()

        pickedDisplayingMode = PickedDisplayingMode.vision

        self.convertedData = [
            MatchTableViewCellType.mainMatchInfo(
                    converter.mainMatchInfo(from: self.rawMatchInfo)
            ),
            MatchTableViewCellType.additionalMatchInfo(
                    converter.additionalMatchInfo(from: self.rawMatchInfo, regions: regions)
            ),
            MatchTableViewCellType.preferredDataViewModePicker(
                    pickedDisplayingMode
            )
        ]

        self.convertedData.append(
                MatchTableViewCellType.wardsMapInfo(converter.wardsMapInfo(from: self.rawMatchInfo)))

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
        return 1
    }

    func getRowsCountInSection(_ section: Int) -> Int {
        return convertedData.count
    }

    func getCellData(for row: Int) -> MatchTableViewCellData {
        return MatchTableViewCellData(type: convertedData[row])
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
