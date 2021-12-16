protocol TeamInfoModuleInput: AnyObject {}

protocol TeamInfoModuleOutput: AnyObject {}

protocol TeamInfoModuleViewOutput: AnyObject {
    func getSectionCount() -> Int
    func getRowsCountInSection(_ section: Int) -> Int
    func getCellData(for row: Int) -> TeamInfoTableViewCellData
}

final class TeamInfoModulePresenter {
    weak var view: TeamInfoModuleViewInput? {
        didSet {
            requestData()
        }
    }

    let output: TeamInfoModuleOutput
    private let converter: TeamInfoConverter
    private let teamInfoService: TeamInfoService
    private var convertedData: [TeamInfoTableViewCellType] = []
    private var matchId: Int
    private var rawTeamMainInfo: TeamInfo!

    required init(converter: TeamInfoConverter, teamInfoService: TeamInfoService,
                  output: TeamInfoModuleOutput, teamId: Int) {
        self.teamInfoService = teamInfoService
        self.output = output
        self.matchId = teamId
        self.converter = converter
        self.state = .loading
    }

    private var state: TeamInfoModuleViewState {
        didSet {
            switch state {
            case .success:
                self.convertedData = [
                    TeamInfoTableViewCellType.mainTeamInfo(
                        converter.teamMainInfo(from: self.rawTeamMainInfo)
                    )
//                    TeamInfoTableViewCellType.teamButtonsInfo(
//                        converter.teamButtonsInfo(from: self.rawTeamMainInfo)
//                    )
                ]
                view?.update(state: .success)
            case .error:
                view?.update(state: .error)
            case .loading:
                view?.update(state: .loading)
            }
        }
    }

    private func requestData() {
        state = .loading
        teamInfoService.requestTeamMainInfo(id: matchId) { [weak self] result in
            guard
                let self = self
            else {
                return
            }
            switch result {
            case .success(let rawTeamMainInfo):
                self.rawTeamMainInfo = rawTeamMainInfo
                self.state = .success
            case .failure:
                self.state = .error
            }
        }
    }

}

extension TeamInfoModulePresenter: TeamInfoModuleInput {}

extension TeamInfoModulePresenter: TeamInfoModuleViewOutput {
    func getSectionCount() -> Int {
        return 1
    }

    func getRowsCountInSection(_ section: Int) -> Int {
        return convertedData.count
    }

    func getCellData(for row: Int) -> TeamInfoTableViewCellData {
        return TeamInfoTableViewCellData(type: convertedData[row])
    }
}
