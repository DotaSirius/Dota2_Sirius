import UIKit

protocol PlayerInfoModuleViewInput: AnyObject {
    func update(state: PlayerInfoModuleViewState)
}

protocol PlayerInfoModuleViewOutput: AnyObject {
    func getMainData() -> PlayerMainInfoView
}

final class PlayerInfoModuleViewController: UIViewController {
    // MARK: - Properties

    private var output: PlayerInfoModuleViewOutput?
    var spiner = UIActivityIndicatorView(style: .large)
    
    private lazy var avatar: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    // MARK: - Init
    
    init(output: PlayerInfoModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Set up UIImage "avatar"

    private func setUpAvatar() {
        view.addSubview(avatar)
        NSLayoutConstraint.activate([
            avatar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            avatar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            avatar.heightAnchor.constraint(equalTo: avatar.widthAnchor)
        ])
    }
}

extension PlayerInfoModuleViewController: PlayerInfoModuleViewInput {
    func update(state: PlayerInfoModuleViewState) {
        switch state {
        case .loading:
            spiner.color = ColorPalette.accent
            view.addSubview(spiner)
            spiner.center = view.center
            spiner.startAnimating()
        case .error:
            spiner.removeFromSuperview()
        case .success:
            spiner.removeFromSuperview()
            setUpAvatar()
        }
    }
}
