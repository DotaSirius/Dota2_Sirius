import UIKit

protocol TeamsHeaderViewDelegate: AnyObject {
    func nameTapped()
    func ratingTapped()
    func winrateTapped()
}

final class TeamsHeaderView: UITableViewHeaderFooterView {
    static let identifier = "TeamsHeaderView"
    weak var delegate: TeamsHeaderViewDelegate?

    private enum Constant {
        static let numWidth: CGFloat = 45
        static let ratingWidth: CGFloat = 70
        static let winrateWidth: CGFloat = 75
        static let numTitle: String = NSLocalizedString("#", comment: "Номер команды в списке")
        static let nameTitle: String = NSLocalizedString("NAME", comment: "Название команды")
        static let ratingTitle: String = NSLocalizedString("RATING", comment: "Рейтинг команды")
        static let winrateTitle: String = NSLocalizedString("WINRATE", comment: "Процент побед")
        static let titleFontSize: CGFloat = 12
        static let headerHeight: CGFloat = 40
    }

    private lazy var numButton = makeButton(with: Constant.numTitle)

    private lazy var nameButton: UIButton = {
        let button = makeButton(with: Constant.nameTitle)
        button.addTarget(nil, action: #selector(nameButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var ratingButton: UIButton = {
        let button = makeButton(with: Constant.ratingTitle)
        button.addTarget(nil, action: #selector(ratingButtonTapped), for: .touchUpInside)
        return button
    }()

    private lazy var winrateButton: UIButton = {
        let button = makeButton(with: Constant.winrateTitle)
        button.addTarget(nil, action: #selector(winrateButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        addView()
    }

    func setup(delegate: TeamsHeaderViewDelegate) {
        self.delegate = delegate
        NSLayoutConstraint.activate([
            numButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            numButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            numButton.widthAnchor.constraint(equalToConstant: Constant.numWidth),
            numButton.heightAnchor.constraint(equalTo: contentView.heightAnchor),

            nameButton.leadingAnchor.constraint(equalTo: numButton.trailingAnchor),
            nameButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            nameButton.heightAnchor.constraint(equalTo: contentView.heightAnchor),

            ratingButton.leadingAnchor.constraint(equalTo: nameButton.trailingAnchor),
            ratingButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            ratingButton.widthAnchor.constraint(equalToConstant: Constant.ratingWidth),
            ratingButton.heightAnchor.constraint(equalTo: contentView.heightAnchor),

            winrateButton.leadingAnchor.constraint(equalTo: ratingButton.trailingAnchor),
            winrateButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            winrateButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            winrateButton.widthAnchor.constraint(equalToConstant: Constant.winrateWidth),
            winrateButton.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }

    private func addView() {
        contentView.addSubview(numButton)
        contentView.addSubview(nameButton)
        contentView.addSubview(ratingButton)
        contentView.addSubview(winrateButton)
    }

    private func makeButton(with title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: Constant.titleFontSize)
        button.setTitleColor(ColorPalette.subtitle, for: .normal)
        button.titleLabel?.textAlignment = .center
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    private func nameButtonTapped() {
        delegate?.nameTapped()
    }

    @objc
    private func ratingButtonTapped() {
        delegate?.ratingTapped()
    }

    @objc
    private func winrateButtonTapped() {
        delegate?.winrateTapped()
    }
}
