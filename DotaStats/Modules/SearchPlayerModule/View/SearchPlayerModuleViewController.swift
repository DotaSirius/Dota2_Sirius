import UIKit

protocol SearchPlayerModuleViewInput: AnyObject {
    func updateState(_ state: SearchPlayerModuleViewState)
}

protocol SearchPlayerModuleViewOutput: AnyObject {
    var count: Int { get }
    func getData(indexPath: IndexPath) -> Players
    func search(_ name: String)
}

class SearchPlayerModuleViewController: UIViewController {
    private var output: SearchPlayerModuleViewOutput?

    init(output: SearchPlayerModuleViewOutput) {
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

// MARK: - SearchModuleViewInput

extension SearchPlayerModuleViewController: SearchPlayerModuleInput {
    func updateState(_ state: SearchPlayerModuleViewState) {
        // TODO: make update view
        switch state {
        case .startScreen:
            // TODO: Start Screen
            print("startScreen")
        case .empty:
            // TODO: anything not found
            print("emptyView")
        case .loading:
            // TODO: Actrivity View
            print("loading")
        case .success:
            // TODO: Show players
            print("success")
        case .failure:
            // TODO: show error image
            print("error")
        }
    }
}
