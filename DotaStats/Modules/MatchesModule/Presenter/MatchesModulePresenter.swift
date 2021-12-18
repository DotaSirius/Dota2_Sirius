import UIKit

protocol MatchesModuleInput: AnyObject {}

protocol MatchesModuleOutput: AnyObject {
    func matchesModule(_ module: MatchesModuleInput, didSelectMatch matchId: Int, on viewController: UIViewController)
}

final class MatchesModulePresenter {
    weak var view: MatchesModuleViewInput? {
        didSet {
            updateView()
        }
    }

    private let matchesService: MatchesService
    private var tournaments: [MatchCollectionPresenterData] = []
    let output: MatchesModuleOutput

    required init(matchesService: MatchesService,
                  output: MatchesModuleOutput) {
        self.matchesService = matchesService
        self.output = output
        state = .none
    }

    private var state: MatchesModulePresenterState {
        didSet {
            switch state {
            case .success(let matches):
                convert(matches)
                view?.update(state: .success)
            case .error(let error):
                view?.update(state: .error(error.localizedDescription))
            case .loading:
                view?.update(state: .loading)
            case .none:
                break
            }
        }
    }

    private func updateView() {
        state = .loading
        _ = matchesService.requestProMatches { [weak self] result in
            switch result {
            case .success(let matches):
                self?.state = .success(matches)
            case .failure(let error):
                self?.state = .error(error)
            }
        }
    }

    private func convert(_ matches: [Match]) {
        for match in matches.sorted(by: >) {
            let newMatch = convertTo(match)

            if let index = tournaments.firstIndex(where: { $0.tournament.leagueName == match.leagueName }) {
                tournaments[index].matches.append(newMatch)
            } else {
                let matchData = MatchCollectionPresenterData(
                    tournament: TournamentViewState(
                        leagueName: match.leagueName,
                        isOpen: false
                    ),
                    matches: [newMatch]
                )
                tournaments.append(matchData)
            }
        }
    }

    private func convertTo(_ match: Match) -> TournamentViewState.Match {
        TournamentViewState.Match(
            radiantTeam: match.radiantName ?? NSLocalizedString("Radiant team", comment: ""),
            radiant: match.radiantWin,
            direTeam: match.direName ?? NSLocalizedString("Dire team", comment: ""),
            id: match.matchId,
            radiantScore: match.radiantScore,
            direScore: match.direScore
        )
    }
}

// MARK: - MatchesModuleInput

extension MatchesModulePresenter: MatchesModuleInput {}

// MARK: - MatchesModuleViewOutput

extension MatchesModulePresenter: MatchesModuleViewOutput {
    func getSectionCount() -> Int {
        tournaments.count
    }

    func getRowsInSection(section: Int) -> Int {
        if tournaments[section].tournament.isOpen {
            return tournaments[section].matches.count
        } else {
            return 0
        }
    }

    func getDataMatch(indexPath: IndexPath) -> TournamentViewState.Match {
        tournaments[indexPath.section].matches[indexPath.row]
    }

    func getDataTournament(section: Int) -> TournamentViewState {
        tournaments[section].tournament
    }

    func matchTapped(on viewController: UIViewController, indexPath: IndexPath) {
        output.matchesModule(
            self,
            didSelectMatch: tournaments[indexPath.section].matches[indexPath.row].id,
            on: viewController
        )
    }

    func tournamentTapped(section: Int) {
        let isOpen = tournaments[section].tournament.isOpen
        tournaments[section].tournament.isOpen = !isOpen
        let matchesCount = tournaments[section].matches.count
        var indexPaths = [IndexPath]()
        for i in 0 ..< matchesCount {
            indexPaths.append(.init(row: i, section: section))
        }
        if isOpen {
            view?.deleteRows(indexPaths)
        } else {
            view?.insertRows(indexPaths)
        }
    }
}
