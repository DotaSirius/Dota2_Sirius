import UIKit

protocol TeamsModuleViewInput: AnyObject {
    func updateState(_ state: TeamsModuleViewState)
}

protocol TeamsModuleViewOutput: AnyObject {
    var countOfRows: Int { get }
    func getData(at indexPath: IndexPath) -> TeamShortInfo
    func selected(at indexPath: IndexPath)
}

final class TeamsModuleViewController: UIViewController {
    private var output: TeamsModuleViewOutput?

    init(output: TeamsModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)

    }

    private enum Constant {
        static let headerHeight: CGFloat = 40
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TeamsCell.self, forCellReuseIdentifier: TeamsCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = ColorPalette.mainBackground
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = .zero
        }

        return tableView
    }()

    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = ColorPalette.mainBackground
        view.addSubview(tableView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.bounds
    }
}

// MARK: - PlayersModuleViewInput

extension TeamsModuleViewController: TeamsModuleViewInput {
    func updateState(_ state: TeamsModuleViewState) {
        switch state {
        case .loading:
            print("loading")
        case .success:
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        case .failure:
            break
        }
    }
}

extension TeamsModuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        output?.countOfRows ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: TeamsCell.identifier) as? TeamsCell,
            let data = output?.getData(at: indexPath)
        else {
            return .init()
        }

        cell.configure(with: data, forIndexPathRow: indexPath.row)
        return cell
    }
}

extension TeamsModuleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let view = view as? TeamsHeaderView else { return }
        view.contentView.backgroundColor = ColorPalette.mainBackground
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = TeamsHeaderView()
        header.setup(delegate: self)
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        Constant.headerHeight
    }
}

extension TeamsModuleViewController: TeamsHeaderViewDelegate {
    func nameTapped() {
        //
    }

    func ratingTapped() {
        //
    }

    func winrateTapped() {
        //
    }
}
