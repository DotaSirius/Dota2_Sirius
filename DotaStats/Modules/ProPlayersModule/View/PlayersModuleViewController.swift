import UIKit

protocol ProPlayersModuleViewInput: AnyObject {
    func showLoading()
    func showPlayers(_ players: [Player])
}

protocol ProPlayersModuleViewOutput: AnyObject {
    func playerSelected(_ player: Player)
}

final class ProPlayersModuleViewController: UIViewController {
    private var output: ProPlayersModuleViewOutput?

    init(output: ProPlayersModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - PlayersModuleViewInput

extension ProPlayersModuleViewController: ProPlayersModuleViewInput {
    func showLoading() {
        // TODO:
    }

    func showPlayers(_ players: [Player]) {
        // TODO:
    }
}
