import UIKit

// MARK: - Protocols

protocol MatchesModuleViewInput: AnyObject {
    func updateState(matchesModuleState: MatchesModuleViewState)
    func updateSection(section: Int)
}

protocol MatchesModuleViewOutput: AnyObject {
    func getSectionCount() -> Int
    func getRowsInSection(section: Int) -> Int
    func getDataMatch(indexPath: IndexPath) -> TournamentViewState.MatchViewState
    func getDataTournament(section: Int) -> TournamentViewState
    func matchTapped(indexPath: IndexPath)
    func tournamentTapped(section: Int)
}

final class MatchesModuleViewController: UIViewController {
    // MARK: - Properties

    private var output: MatchesModuleViewOutput?
    var spiner = UIActivityIndicatorView(style: .large)
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ListMatchesCell.self, forCellReuseIdentifier: ListMatchesCell.reuseIdentifier)
        table.register(ListTournamentsCell.self, forHeaderFooterViewReuseIdentifier: ListTournamentsCell.reuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = ColorPalette.mainBackground
        table.separatorColor = ColorPalette.separator
        table.separatorInset = .zero
        table.dataSource = self
        table.delegate = self
        return table
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = ColorPalette.alternatеBackground
        label.text = "MATCHES"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = ColorPalette.mainText
        return label
    }()

    // MARK: - Init

    init(output: MatchesModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Set up UILabel "MATCHES"

    func setUpLabel() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            label.bottomAnchor.constraint(equalTo: tableView.topAnchor),
        ])
    }

    // MARK: - Set up UITableView

    func setUpTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - MatchesModuleViewInput

extension MatchesModuleViewController: MatchesModuleViewInput {
    func updateState(matchesModuleState: MatchesModuleViewState) {
        switch matchesModuleState {
        case .loading:
            spiner.color = .systemOrange
            view.addSubview(spiner)
            spiner.center = view.center
            spiner.startAnimating()
        case .error(_):
            spiner.removeFromSuperview()
        case .success:
            spiner.removeFromSuperview()
            setUpTableView()
        }
    }

    func updateSection(section: Int) {
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}

// MARK: - UITableViewDataSource

extension MatchesModuleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return output?.getSectionCount() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output?.getRowsInSection(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 55
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = output?.getDataMatch(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListMatchesCell.reuseIdentifier, for: indexPath) as? ListMatchesCell else { return UITableViewCell() }
        cell.firstTeam.text = data?.radiantTeam
        cell.score.text = data?.score
        cell.secondTeam.text = data?.direTeam
        cell.backgroundColor = ColorPalette.mainBackground
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MatchesModuleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("eeeeeeeeeeeeeeeeeeeeeeeee")
        tableView.deselectRow(at: indexPath, animated: true)
        output?.matchTapped(indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension MatchesModuleViewController: ListTournamentsCellDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let data = output?.getDataTournament(section: section)
        let header = ListTournamentsCell()
        header.setup(withTitle: data?.leagueName ?? "ChampionShip", section: section, delegate: self)
        return header
    }

    func toggleSection(header: ListTournamentsCell, section: Int) {
        print("toggleSection")
//        output?.cellTapped(indexPath: section)
//
//        let collapsed = !sections[section].expanded
//
//                // Toggle collapse
//        sections[section].expanded = collapsed
        // header.setCollapsed(collapsed)
//
//        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
    }
}
