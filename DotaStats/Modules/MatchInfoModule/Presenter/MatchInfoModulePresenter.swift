import Foundation

protocol MatchInfoModuleInput: AnyObject {}

protocol MatchInfoModuleOutput: AnyObject {
    // TODO: - Integration with Coordinator
//    func playersModule(_ module: MatchInfoModuleInput, didSelectPlayer player: Player)
}

protocol MatchInfoModuleViewOutput: AnyObject {
    func getSectionCount() -> Int
    func getRowsCountInSection() -> Int
    func getCellData(indexPath: Int) -> MatchTableViewCellData
}

final class MatchInfoModulePresenter {
    weak var view: MatchInfoModuleViewInput?
    private let networkService: NetworkService
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
        return 4
    }

    func getCellData(indexPath: Int) -> MatchTableViewCellData {
        switch indexPath {
        case 0:
            let cellType = MatchTableViewCellType.mainMatchInfo(MainMatchInfo(winnersLabelText: "Raidant Victory", gameTimeLabelText: "24:45", firstTeamScoreLabelText: "35", secondTeamScoreLabelText: "11", matchEndTimeLabelText: "34:28"))
            return MatchTableViewCellData(type: cellType)
        case 1:
            let cellType = MatchTableViewCellType.additionalMatchInfo(AdditionalMatchInfo(matchIdLabelText: "12345678", regionLabelText: "Europe", skillLabelText: "Normal"))
            return MatchTableViewCellData(type: cellType)
        default:
            let cellType = MatchTableViewCellType.mainMatchInfo(MainMatchInfo(winnersLabelText: "", gameTimeLabelText: "KEK", firstTeamScoreLabelText: "", secondTeamScoreLabelText: "", matchEndTimeLabelText: "LOL"))
            return MatchTableViewCellData(type: cellType)
        }
    }
}
