import UIKit
// MARK: - Protocols
protocol MatchesModuleViewInput: AnyObject {
    func updateState(matchesModuleState: MatchesModuleState)
    func updateSection(section: Int)
}

protocol MatchesModuleViewOutput: AnyObject {
    func getSectionCount() -> Int
    func getRowsInSection(section: Int) -> Int
    func getData(indexPath: IndexPath) -> MatchCellType
    func cellTapped(indexPath: IndexPath)
}

final class MatchesModuleViewController: UIViewController  {
    // MARK: - Properties
    private var output: MatchesModuleViewOutput?
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(ListMatchesCell.self, forCellReuseIdentifier: ListMatchesCell.reuseIdentifier)
        table.register(ListTournamentsCell.self, forCellReuseIdentifier: ListTournamentsCell.reuseIdentifier)
        table.translatesAutoresizingMaskIntoConstraints = false;
        table.backgroundColor = ColorPalette.mainBackground
        table.separatorColor = ColorPalette.separator
        table.separatorInset = .zero
        table.dataSource = self
        table.delegate = self
        return table
    }()
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false;
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
            label.topAnchor.constraint(equalTo: view.topAnchor, constant:  150),
            label.bottomAnchor.constraint(equalTo: tableView.topAnchor)
        ])
    }
    
    // MARK: - Set up UITableView
    func setUpTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant:  200),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - MatchesModuleViewInput

extension MatchesModuleViewController: MatchesModuleViewInput {
    func updateState(matchesModuleState: MatchesModuleState) {
        // TODO
    }
    
    func updateSection(section: Int) {
        // TODO
    }
}

// MARK: - UITableViewDataSource
extension MatchesModuleViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTournamentsCell.reuseIdentifier, for: indexPath) as? ListTournamentsCell else {return  UITableViewCell()}
        cell.addView()
        cell.title.text = "fjk kf l fsjkl "
        cell.backgroundColor = ColorPalette.mainBackground

        return cell
    }
}

// MARK: - UITableViewDelegate
extension MatchesModuleViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
