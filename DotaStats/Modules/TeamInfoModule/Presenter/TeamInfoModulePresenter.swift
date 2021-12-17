protocol TeamInfoModuleInput: AnyObject {}

protocol TeamInfoModuleOutput: AnyObject {}

protocol TeamInfoModuleViewOutput: AnyObject {
    func getSectionCount() -> Int
    func getRowsCountInSection(_ section: Int) -> Int
    func getCellData(for row: Int) -> TeamInfoTableViewCellData
    func pickSection(_ pickedSection: Int)
}

final class TeamInfoModulePresenter {
    weak var view: TeamInfoModuleViewInput? {
        didSet {
            requestData()
        }
    }

    let output: TeamInfoModuleOutput
    private let converter: TeamInfoConverterImp
    private let teamInfoService: TeamInfoService
    private var convertedData: [TeamInfoTableViewCellType] = []
    private var matchId: Int
    private var rawTeamMainInfo: TeamInfo?
    private var rawTeamPlayersInfo: [TeamPlayers] = []
    private var rawTeamHeroesInfo: [TeamHeroes] = []
    private var rawMatchesTeamInfo: [TeamMatches] = []

    required init(converter: TeamInfoConverterImp, teamInfoService: TeamInfoService,
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
                    showMatchesData()
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

    private func showMatchesData() {
        convertedData.removeAll()
        convertedData = [
            TeamInfoTableViewCellType.mainTeamInfo(
                converter.teamMainInfo(from: self.rawTeamMainInfo!)
            ),
            TeamInfoTableViewCellType.preferredDataViewModePicker,
            TeamInfoTableViewCellType.teamsInfoMatchesHeader
        ]
        let teamMatchesInfo = converter.teamMatchesInfo(from: rawMatchesTeamInfo).map {
            TeamInfoTableViewCellType.teamsInfoMatches($0)
        }
        convertedData.append(contentsOf: teamMatchesInfo)
        view?.update(state: .update)
    }
    private func showPlayersData() {
        convertedData.removeAll()
        convertedData = [
            TeamInfoTableViewCellType.mainTeamInfo(
                converter.teamMainInfo(from: self.rawTeamMainInfo!)
            ),
            TeamInfoTableViewCellType.preferredDataViewModePicker,
            TeamInfoTableViewCellType.currentHeroesHeader
        ]
        let teamPlayersInfo = converter.teamPlayersInfo(from: self.rawTeamPlayersInfo).map({
            TeamInfoTableViewCellType.currentPlayersInfo($0)
        })
        convertedData.append(contentsOf: teamPlayersInfo)
        view?.update(state: .update)
    }

    private func showHeroesData() {
        convertedData.removeAll()
        convertedData = [
            TeamInfoTableViewCellType.mainTeamInfo(
                converter.teamMainInfo(from: self.rawTeamMainInfo!)
            ),
            TeamInfoTableViewCellType.preferredDataViewModePicker,
            TeamInfoTableViewCellType.currentHeroesHeader
        ]
        let teamHeroesInfo = converter.teamHeroesInfo(from: self.rawTeamHeroesInfo).map({
            TeamInfoTableViewCellType.currentHeroesInfo($0)
        })
        convertedData.append(contentsOf: teamHeroesInfo)
        view?.update(state: .update)
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
                if !self.rawTeamPlayersInfo.isEmpty && !self.rawTeamHeroesInfo.isEmpty && !self.rawMatchesTeamInfo.isEmpty {
                    self.state = .success
                }
            case .failure:
                self.state = .error
            }
        }

        teamInfoService.requestTeamPlayers(id: matchId) { [weak self] result in
            guard
                let self = self
            else {
                return
            }
            switch result {
            case .success(let rawTeamPlayersInfo):
                self.rawTeamPlayersInfo = rawTeamPlayersInfo
                if self.rawTeamMainInfo != nil && !self.rawTeamHeroesInfo.isEmpty  && !self.rawMatchesTeamInfo.isEmpty  {
                    self.state = .success
                }
            case .failure:
                self.state = .error
            }
        }

        teamInfoService.requestTeamHeroes(id: matchId) { [weak self] result in
            guard
                let self = self
            else {
                return
            }
            switch result {
            case .success(let rawTeamHeroesInfo):
                self.rawTeamHeroesInfo = rawTeamHeroesInfo
                if self.rawTeamMainInfo != nil && !self.rawTeamPlayersInfo.isEmpty  && !self.rawMatchesTeamInfo.isEmpty  {
                    self.state = .success
                }
            case .failure:
                self.state = .error
            }
        }

        teamInfoService.requestTeamMatches(id: matchId) { [weak self] result in
                    guard
                        let self = self
                    else {
                        return
                    }

                    switch result {
                    case .success(let rawMatchesTeamInfo):
                        self.rawMatchesTeamInfo = rawMatchesTeamInfo
                    if self.rawTeamMainInfo != nil && !self.rawTeamPlayersInfo.isEmpty && !self.rawTeamHeroesInfo.isEmpty {
                            self.state = .success
                        }
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

extension TeamInfoModulePresenter {
    func pickSection(_ pickedSection: Int) {
        switch pickedSection {
        case 0:
            showMatchesData()
        case 1:
            showPlayersData()
        case 2:
            showHeroesData()
        default:
            break
        }
    }
}
