import Foundation

protocol MatchInfoModuleInput: AnyObject {
    func setMatchId(_ id: Int)
}

protocol MatchInfoModuleOutput: AnyObject {}

protocol MatchInfoModuleViewOutput: AnyObject {
    func getSectionCount() -> Int
    func getRowsCountInSection(_ section: Int) -> Int
    func getCellData(for row: Int) -> MatchTableViewCellData
}

final class MatchInfoModulePresenter {
    weak var view: MatchInfoModuleViewInput?

    let output: MatchInfoModuleOutput
    private let converter: MatchInfoConverter
    private var convertedData: [MatchTableViewCellType] = []
    private let networkService: MatchDetailService
    private var rawMatchInfo: MatchDetail!
    private var convertedMatchInfo: [MatchTableViewCellType]?
    private var matchId: Int

    private var state: MatchesInfoModuleViewState {
        didSet {
            switch state {
            case .success:
                self.convertedData = [
                    MatchTableViewCellType.mainMatchInfo(
                        converter.mainMatchInfo(rawMatchInfo: self.rawMatchInfo)
                    ),
                    MatchTableViewCellType.additionalMatchInfo(
                        converter.additionalMatchInfo(rawMatchInfo: self.rawMatchInfo)
                    ),
                    MatchTableViewCellType.teamMatchInfo(
                        converter.radiantMatchInfo(rawMatchInfo: self.rawMatchInfo)
                    ),
                    MatchTableViewCellType.matchPlayerHeaderInfo
                ]
                for index in 0..<5 {
                    self.convertedData.append(
                        MatchTableViewCellType.matchPlayerInfo(
                            converter.playerInfo(rawMatchInfo: self.rawMatchInfo, playerNumber: index)
                        )
                    )
                }
                self.convertedData.append(
                    MatchTableViewCellType.teamMatchInfo(
                        converter.direMatchInfo(rawMatchInfo: self.rawMatchInfo)
                    )
                )
                for index in 5..<10 {
                    self.convertedData.append(
                        MatchTableViewCellType.matchPlayerInfo(
                            converter.playerInfo(rawMatchInfo: self.rawMatchInfo, playerNumber: index)
                        )
                    )
                }
                view?.update(state: .success)
            case .error:
                view?.update(state: .error)
            case .loading:
                view?.update(state: .loading)
            }
        }
    }

    required init(converter: MatchInfoConverter, output: MatchInfoModuleOutput, networkService: MatchDetailService) {
        self.converter = converter
        self.output = output
        self.networkService = networkService
        self.state = .loading
        self.matchId = 1
    }

    private func updateView() {
        state = .loading
        _ = networkService.requestMatchDetail(id: matchId) { [weak self] result in
            guard
                let self = self
            else {
                return
            }
            switch result {
            case .success(let rawMatchInfo):
                self.rawMatchInfo = rawMatchInfo
                self.state = .success

            case .failure(let error):
                self.state = .error
                print(error)
            }
        }
    }
}

// MARK: - MatchInfoModuleInput

extension MatchInfoModulePresenter: MatchInfoModuleInput {
    func setMatchId(_ id: Int) {
        matchId = id
        updateView()
    }
}

// MARK: - MatchInfoModuleViewOutput

extension MatchInfoModulePresenter: MatchInfoModuleViewOutput {
    func getSectionCount() -> Int {
        return 1
    }

    func getRowsCountInSection(_ section: Int) -> Int {
        return convertedData.count
    }

    func getCellData(for row: Int) -> MatchTableViewCellData {
        return MatchTableViewCellData(type: convertedData[row])
    }
}
