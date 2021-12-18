import UIKit

protocol TeamsModuleInput: AnyObject {}

protocol TeamsModuleOutput: AnyObject {
    func teamsModule(on viewController: UIViewController, _ module: TeamsModuleInput, didSelectTeam teamId: Int)
}

final class TeamsModulePresenter {
    weak var view: TeamsModuleViewInput? {
        didSet {
            loading()
        }
    }

    private enum Constant {
        static let firstEmoji: String = NSLocalizedString("🥇", comment: "Эмодзи для первого места в списке команд")
        static let secondEmoji: String = NSLocalizedString("🥈", comment: "Эмодзи для второго места в списке команд")
        static let thirdEmoji: String = NSLocalizedString("🥉", comment: "Эмодзи для третьего места в списке команд")
        static let yearsSeconds: TimeInterval = 31622400
    }

    private let teamsService: TeamsService
    let output: TeamsModuleOutput

    private var teams = [TeamShortInfo]()
    private var requestToken: Cancellable?

    init(teamsService: TeamsService, output: TeamsModuleOutput) {
        self.teamsService = teamsService
        self.output = output
    }

    private func loading() {
        view?.updateState(.loading)

        let teamsRequestToken = teamsService.requestTeams { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let teamResult):
                let filteredTeams = teamResult.filter { team in
                    team.lastMatchTime.distance(to: Date()) < Constant.yearsSeconds
                            && !team.name.isEmpty
                            && team.logoUrl != nil
                            && !team.tag.isEmpty
                }
                self.teams = filteredTeams.map { TeamShortInfo(from: $0) }
                self.view?.updateState(.success)
            case .failure:
                self.view?.updateState(.failure)
            }
        }

        requestToken = teamsRequestToken
    }

    private func getNumFromIndexPathRow(_ num: Int) -> String {
        switch num {
        case 0:
            return Constant.firstEmoji
        case 1:
            return Constant.secondEmoji
        case 2:
            return Constant.thirdEmoji
        default:
            return "\(num + 1)"
        }
    }

    deinit {
        requestToken?.cancel()
    }
}

// MARK: - TeamsModuleInput

extension TeamsModulePresenter: TeamsModuleInput {}

// MARK: - TeamsModuleViewOutput

extension TeamsModulePresenter: TeamsModuleViewOutput {
    var countOfRows: Int {
        teams.count
    }

    func getData(at indexPath: IndexPath) -> TeamShortInfo {
        let team = teams[indexPath.row]
        team.num = getNumFromIndexPathRow(indexPath.row)
        return team
    }

    func selected(at indexPath: IndexPath, on viewController: UIViewController) {
        let team = teams[indexPath.row]
        output.teamsModule(on: viewController, self, didSelectTeam: team.teamId)
    }
}
