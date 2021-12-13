import Foundation

protocol MatchInfoModuleInput: AnyObject {}

protocol MatchInfoModuleOutput: AnyObject {
    // TODO: - Integration with Coordinator
//    func playersModule(_ module: MatchInfoModuleInput, didSelectPlayer player: Player)
}

protocol MatchInfoModuleViewOutput: AnyObject {
    func getSectionCount() -> Int
    func getRowsCountInSection() -> Int
    func getCellData(for row: Int) -> MatchTableViewCellData
}

final class MatchInfoModulePresenter {
    weak var view: MatchInfoModuleViewInput?
    private let networkService: NetworkService
    private var convertedData: [MatchTableViewCellType] = {
        [
            MatchTableViewCellType.mainMatchInfo(MainMatchInfo(winnersLabelText: "Raidant Victory", gameTimeLabelText: "24:45", firstTeamScoreLabelText: "35", secondTeamScoreLabelText: "11", matchEndTimeLabelText: "34:28")),
            MatchTableViewCellType.additionalMatchInfo(AdditionalMatchInfo(matchIdLabelText: "12345678", regionLabelText: "Europe", skillLabelText: "Normal")),
            MatchTableViewCellType.matchPlayerInfo(PlayerList(playerNameLabelText: "Slayer", playerRankText: "Immortal", playerKillsText: "18", playerDeathsText: "2", playerAssitsText: "10", playerGoldText: "32012")),
        ]
    }()

    let output: MatchInfoModuleOutput

    required init(networkService: NetworkService,
                  output: MatchInfoModuleOutput)
    {
        self.networkService = networkService
        self.output = output
    }
}

// MARK: - MatchInfoModuleInput

extension MatchInfoModulePresenter: MatchInfoModuleInput {}

// MARK: - MatchInfoModuleViewOutput

extension MatchInfoModulePresenter: MatchInfoModuleViewOutput {
    func getSectionCount() -> Int {
        return 1
    }

    func getRowsCountInSection() -> Int {
        return convertedData.count
    }

    func getCellData(for row: Int) -> MatchTableViewCellData {
        return MatchTableViewCellData(type: convertedData[row])
    }
}
