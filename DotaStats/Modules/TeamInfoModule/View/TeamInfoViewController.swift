import UIKit

protocol TeamInfoModuleViewInput: AnyObject {
    func update(state: TeamInfoModuleViewState)
}

final class TeamInfoModuleViewController: UIViewController {
    private var output: TeamInfoModuleViewOutput?
    private var errorConstraint: NSLayoutConstraint?
    private lazy var spinnerView: UIActivityIndicatorView = .init(style: .large)
    var data: TeamInfoTableViewCellData?

    init(output: TeamInfoModuleViewOutput) {
        super.init(nibName: nil, bundle: nil)
        self.output = output
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var tableView: UITableView = {
            let tableView = UITableView()
            tableView.register(MainTeamInfoTableViewCell.self,
                               forCellReuseIdentifier: MainTeamInfoTableViewCell.reuseIdentifier)
            tableView.register(TeamButtonsInfoTableViewCell.self,
                           forCellReuseIdentifier: TeamButtonsInfoTableViewCell.reuseIdentifier)
            tableView.register(TeamsInfoMatchesHeader.self,
                       forCellReuseIdentifier: TeamsInfoMatchesHeader.reuseIdentifier)
            tableView.register(CurrentPlayersCell.self,
                   forCellReuseIdentifier: CurrentPlayersCell.reuseIdentifier)
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
        let tapActionHideError = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapActionHideError)
        return view
    }()

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

    private func setupLoading() {
        spinnerView.color = ColorPalette.accent
        view.addSubview(spinnerView)
        spinnerView.center = view.center
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorPalette.mainBackground
        setupErrorViewConstraints()
    }
}

extension TeamInfoModuleViewController: UITableViewDelegate, UITableViewDataSource {
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
                withIdentifier: data.type.reuseIdentificator,
                for: indexPath) as? (UITableViewCell & DetailedTeamInfoCellConfigurable)
        else {
            // TODO: - Error handling
            return UITableViewCell()
        }
        let isEven = indexPath.row % 2 == 0
        let matchPlayersCellIndexes = indexPath.row > 3
        // swiftlint:disable line_length
        cell.backgroundColor = (isEven && matchPlayersCellIndexes) ? ColorPalette.alternativeBackground : ColorPalette.mainBackground
        // swiftlint:enable line_length
        cell.configure(with: data)
        return cell
    }
}

extension TeamInfoModuleViewController: TeamInfoModuleViewInput {
    func update(state: TeamInfoModuleViewState) {
            switch state {
            case .loading:
                spinnerView.color = ColorPalette.accent
                view.addSubview(spinnerView)
                spinnerView.center = view.center
                spinnerView.startAnimating()
            case .error:
                spinnerView.removeFromSuperview()
                showError()
            case .success:
                view.addSubview(tableView)
                setupConstraints()
            }
        }
}
