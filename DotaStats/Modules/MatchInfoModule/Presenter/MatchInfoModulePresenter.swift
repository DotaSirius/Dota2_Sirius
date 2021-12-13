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
    let output: MatchInfoModuleOutput
    private let converter: MatchInfoConverter

    private var convertedData: [MatchTableViewCellType]
//            MatchTableViewCellType.mainMatchInfo(MainMatchInfo(winnersLabelText: "Raidant Victory", gameTimeLabelText: "24:45", firstTeamScoreLabelText: "35", secondTeamScoreLabelText: "11", matchEndTimeLabelText: "34:28")),
//            MatchTableViewCellType.additionalMatchInfo(AdditionalMatchInfo(matchIdLabelText: "12345678", regionLabelText: "Europe", skillLabelText: "Normal")),
//            MatchTableViewCellType.matchPlayerInfo(PlayerList(playerNameLabelText: "Slayer", playerRankText: "Immortal", playerKillsText: "18", playerDeathsText: "2", playerAssitsText: "10", playerGoldText: "32012")),

    required init(converter: MatchInfoConverter, output: MatchInfoModuleOutput) {
        self.converter = converter
        self.output = output
        self.convertedData = [
            MatchTableViewCellType.mainMatchInfo(converter.getMainMatchInfo()),
            MatchTableViewCellType.additionalMatchInfo(converter.getAdditionalMatchInfo()),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 0)),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 1)),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 2)),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 3)),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 4)),
        ]
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
