import UIKit

protocol MatchInfoModuleViewInput: AnyObject {
    func update(state: MatchesInfoModuleViewState)
}

protocol MatchInfoModuleViewOutput: AnyObject {
    func getSectionCount() -> Int
    func getRowsCountInSection(_ section: Int) -> Int
    func getCellData(for row: Int) -> MatchTableViewCellData
    func matchTapped(indexPath: IndexPath, on viewController: UIViewController)
    func pickSection(_ pickedSection: Int)
}

final class MatchInfoViewController: UIViewController {
    private lazy var loadingView = SquareLoadingView()

    var output: MatchInfoModuleViewOutput?
    var data: MatchTableViewCellData?

    private var errorConstraint: NSLayoutConstraint?

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AdditionalMatchInfoTableViewCell.self,
                           forCellReuseIdentifier: AdditionalMatchInfoTableViewCell.reuseIdentifier)
        tableView.register(MainMatchInfoTableViewCell.self,
                           forCellReuseIdentifier: MainMatchInfoTableViewCell.reuseIdentifier)
        tableView.register(MatchPlayerCell.self,
                           forCellReuseIdentifier: MatchPlayerCell.reuseIdentifier)
        tableView.register(TeamMatchInfoTableViewCell.self,
                           forCellReuseIdentifier: TeamMatchInfoTableViewCell.reuseIdentifier)
        tableView.register(PlayersTableHeaderCell.self,
                           forCellReuseIdentifier: PlayersTableHeaderCell.reuseIdentifier)
        tableView.register(PreferredDataViewModePickerCell.self,
                           forCellReuseIdentifier: PreferredDataViewModePickerCell.reuseIdentifier)
        tableView.register(WardsMapTableViewCell.self,
                forCellReuseIdentifier: WardsMapTableViewCell.reuseIdentifier)
        tableView.register(PlotGpmTableViewCell.self,
                forCellReuseIdentifier: PlotGpmTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = ColorPalette.mainBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        return tableView
    }()

    private lazy var errorView: ErrorView = {
        let view = ErrorView()
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        let tapActionGestureRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(handleTapOnErrorScreen(_:))
        )
        view.addGestureRecognizer(tapActionGestureRecognizer)
        return view
    }()

    init(output: MatchInfoModuleViewOutput) {
        super.init(nibName: nil, bundle: nil)
        self.title = "Match"
        self.output = output
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.mainBackground
        setupErrorViewConstraints()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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

    @objc func handleTapOnErrorScreen(_: UITapGestureRecognizer) {
        hideError()
    }
}

extension MatchInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard
            let output = output
        else {
            // TODO: - Error handling
            return 0
        }
        return output.getRowsCountInSection(0)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let data = output?.getCellData(for: indexPath.row),
            let cell = tableView.dequeueReusableCell(
                withIdentifier: data.type.reuseIdentifier,
                for: indexPath
            ) as? (UITableViewCell & DetailedMatchInfoCellConfigurable)
        else {
            // TODO: - Error handling
            return UITableViewCell()
        }

        if let modeCell = cell as? PreferredDataViewModePickerCell {
            modeCell.output = output
        }

        let isEven = indexPath.row % 2 == 0
        let matchPlayersCellIndexes = indexPath.row > 3
        // swiftlint:disable line_length
        cell.backgroundColor = (!isEven && matchPlayersCellIndexes) ? ColorPalette.alternativeBackground : ColorPalette.mainBackground
        // swiftlint:enable line_length
        cell.configure(with: data)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        output?.matchTapped(indexPath: indexPath, on: self)
    }
}

extension MatchInfoViewController: MatchInfoModuleViewInput {
    func update(state: MatchesInfoModuleViewState) {
        switch state {
        case .loading:
            view.addSubview(loadingView)
            loadingView.center = view.center
            loadingView.startAnimation()
        case .error:
            loadingView.stopAnimation()
            showError()
        case .success:
            loadingView.stopAnimation()
            view.addSubview(tableView)
            setupConstraints()
        case .update:
            tableView.reloadData()
        }
    }
}
