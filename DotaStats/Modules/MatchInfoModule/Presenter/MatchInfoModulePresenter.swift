import Foundation

protocol MatchInfoModuleInput: AnyObject {}

protocol MatchInfoModuleOutput: AnyObject {
    // TODO: - Integration with Coordinator
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

    required init(converter: MatchInfoConverter, output: MatchInfoModuleOutput) {
        self.converter = converter
        self.output = output
        self.convertedData = [
            MatchTableViewCellType.mainMatchInfo(converter.getMainMatchInfo()),
            MatchTableViewCellType.additionalMatchInfo(converter.getAdditionalMatchInfo()),
            MatchTableViewCellType.teamMatchInfo(converter.getRadiantMatchInfo()),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 0)),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 1)),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 2)),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 3)),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 4)),
            MatchTableViewCellType.teamMatchInfo(converter.getDireMatchInfo()),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 5)),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 6)),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 7)),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 8)),
            MatchTableViewCellType.matchPlayerInfo(converter.getPlayerInfo(number: 9)),
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
