import UIKit

// MARK: - Protocols

protocol MatchesModuleViewInput: AnyObject {
    func update(state: MatchesModuleViewState)
    func insertRows(_ rows: [IndexPath])
    func deleteRows(_ rows: [IndexPath])
}

protocol MatchesModuleViewOutput: AnyObject {
    func getSectionCount() -> Int
    func getRowsInSection(section: Int) -> Int
    func getDataMatch(indexPath: IndexPath) -> TournamentViewState.Match
    func getDataTournament(section: Int) -> TournamentViewState
    func matchTapped(on viewController: UIViewController, indexPath: IndexPath)
    func tournamentTapped(section: Int)
}

final class MatchesModuleViewController: UIViewController {
    // MARK: - Properties

    private var output: MatchesModuleViewOutput?
    private var errorConstraint: NSLayoutConstraint?
    private lazy var loadingView = SquareLoadingView()

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ListMatchesCell.self, forCellReuseIdentifier: ListMatchesCell.reuseIdentifier)
        table.register(
            ListTournamentsCell.self,
            forHeaderFooterViewReuseIdentifier: ListTournamentsCell.reuseIdentifier
        )
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = ColorPalette.mainBackground
        table.separatorColor = ColorPalette.separator
        table.separatorInset = .zero
        table.dataSource = self
        table.delegate = self
        return table
    }()

    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        let tapActionHideError = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapActionHideError)
        return view
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
        setupErrorViewConstraints()
    }

    // MARK: ErrorView Constraints

    private func setupErrorViewConstraints() {
        view.addSubview(errorView)
        let errorConstraint = errorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        NSLayoutConstraint.activate([
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            errorConstraint,
            errorView.heightAnchor.constraint(equalToConstant: 90)
        ])
        self.errorConstraint = errorConstraint
    }

    // MARK: Show/hide errors function

    func showError() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveEaseInOut]) {
            self.errorConstraint?.constant = 35
            self.errorView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }

    func hideError() {
        UIView.animate(withDuration: 0.5,
                       delay: 0.0,
                       options: [.curveEaseOut]) {
            self.errorConstraint?.constant = 0
            self.errorView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }

    @objc func handleTap(_: UITapGestureRecognizer) {
        hideError()
    }

    // MARK: - Setup UITableView

    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    // MARK: - Setup Loading

    private func setupLoading() {
        view.addSubview(loadingView)
        loadingView.center = view.center
    }
}

// MARK: - MatchesModuleViewInput

extension MatchesModuleViewController: MatchesModuleViewInput {
    func update(state: MatchesModuleViewState) {
        switch state {
        case .loading:
            hideError()
            setupLoading()
            loadingView.startAnimation()
        case .error:
            loadingView.stopAnimation()
            showError()
        case .success:
            hideError()
            loadingView.stopAnimation()
            setupTableView()
        }
    }

    func insertRows(_ rows: [IndexPath]) {
        tableView.insertRows(at: rows, with: .none)
        guard let head = tableView.headerView(forSection: rows[0].section)
                as? ListTournamentsCell else { return }
        head.setCollapsed(false)
    }

    func deleteRows(_ rows: [IndexPath]) {
        tableView.deleteRows(at: rows, with: .none)
        guard let head = tableView.headerView(forSection: rows[0].section)
                as? ListTournamentsCell else { return }
        head.setCollapsed(true)
    }
}

// MARK: - UITableViewDataSource

extension MatchesModuleViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        output?.getSectionCount() ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.getRowsInSection(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        55
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = output?.getDataMatch(indexPath: indexPath)
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListMatchesCell.reuseIdentifier, for: indexPath
        ) as? ListMatchesCell else {
            return UITableViewCell()
        }
        cell.configure(with: data!)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension MatchesModuleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.matchTapped(on: self, indexPath: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - ListTournamentsCellDelegate

extension MatchesModuleViewController: ListTournamentsCellDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let data = output?.getDataTournament(section: section) else { return nil }
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: ListTournamentsCell.reuseIdentifier)
                as? ListTournamentsCell else { return nil }
        header.configure(with: data, section: section, delegate: self)

        return header
    }

    func toggleSection(header: ListTournamentsCell, section: Int) {
        output?.tournamentTapped(section: section)
    }
}
