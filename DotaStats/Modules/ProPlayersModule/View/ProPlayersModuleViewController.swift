import UIKit

protocol ProPlayersModuleViewInput: AnyObject {
    func updateState(_ state: ProPlayerModuleViewState)
}

protocol ProPlayersModuleViewOutput: AnyObject {
    func playerSelected(_ player: Player)
}

final class ProPlayersModuleViewController: UIViewController {
//    private var output: ProPlayersModuleViewOutput?
//
//    init(output: ProPlayersModuleViewOutput) {
//        self.output = output
//        super.init(nibName: nil, bundle: nil)
//
//    }
    private lazy var tableView = UITableView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        tableView.register(ProPlayerCell.self, forCellReuseIdentifier: ProPlayerCell.identifier)
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
}

// MARK: - PlayersModuleViewInput

extension ProPlayersModuleViewController: ProPlayersModuleViewInput {
    func updateState(_ state: ProPlayerModuleViewState) {
        //
    }
}

extension ProPlayersModuleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProPlayerCell.identifier) as? ProPlayerCell else {
            return .init()
        }
        let isEven = indexPath.row % 2 == 0
        cell.configure(isEven: isEven)
        return cell 
    }
    
//    zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz <- 32
}

