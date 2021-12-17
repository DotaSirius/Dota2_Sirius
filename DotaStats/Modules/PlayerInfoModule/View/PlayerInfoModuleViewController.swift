import UIKit

protocol PlayerInfoModuleViewInput: AnyObject {
    func update(state: PlayerInfoModuleViewState)
}

protocol PlayerInfoModuleViewOutput: AnyObject {
    func getCellData(forRow: Int) -> PlayerTableViewCellData
    func getRowsInSection(section: Int) -> Int
}

final class PlayerInfoModuleViewController: UIViewController {
    // MARK: - Properties

    private var output: PlayerInfoModuleViewOutput?
    private var errorConstraint: NSLayoutConstraint?
    private var first = true
    private var data: PlayerTableViewCellData?
    private var spiner = UIActivityIndicatorView(style: .large)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupErrorViewConstraints()
        view.backgroundColor = ColorPalette.mainBackground
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PlayerMainInfoCell.self,
                           forCellReuseIdentifier: PlayerMainInfoCell.reuseIdentifier)
        tableView.register(PlayerWLCell.self,
                           forCellReuseIdentifier: PlayerWLCell.reuseIdentifier)
        tableView.register(RecentMatchesTitle.self,
                           forCellReuseIdentifier: RecentMatchesTitle.reuseIdentifier)
        tableView.register(RecentMatchesHeader.self,
                           forCellReuseIdentifier: RecentMatchesHeader.reuseIdentifier)
        tableView.register(PlayerMatchCell.self,
                           forCellReuseIdentifier: PlayerMatchCell.reuseIdentifier)

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

    // MARK: - Init

    init(output: PlayerInfoModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
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

    @objc func handleTap(_: UITapGestureRecognizer) {
        hideError()
    }
}

extension PlayerInfoModuleViewController: PlayerInfoModuleViewInput {
    func update(state: PlayerInfoModuleViewState) {
        switch state {
        case .loading:
            hideError()
            spiner.color = ColorPalette.accent
            view.addSubview(spiner)
            spiner.center = view.center
            spiner.startAnimating()
        case .error:
            showError()
            spiner.removeFromSuperview()
        case .successWL, .successMain, .successMatch:
            hideError()
            spiner.removeFromSuperview()
            if first {
                setupTableView()
                first = false
            }
            tableView.reloadData()
        }
    }
}

extension PlayerInfoModuleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.getRowsInSection(section: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let data = output?.getCellData(forRow: indexPath.row),
            let cell = tableView.dequeueReusableCell(
                withIdentifier: data.reuseIdentificator,
                for: indexPath) as? (UITableViewCell & PlayerInfoCellConfigurable)
        else {
            // TODO: - Error handling
            return UITableViewCell()
        }
        cell.backgroundColor = ColorPalette.mainBackground
        cell.configure(with: data)
        return cell
    }
}