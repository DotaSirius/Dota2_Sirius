import UIKit

final class RecentMatchesHeader: UITableViewCell {
    static let reuseIdentifier = "RecentMatchesHeader"

    // MARK: - Properties

    private lazy var hero: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 13)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var gameMode: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 13)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var duration: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 13)
        name.textAlignment = .center
        name.numberOfLines = 2
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var kill: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.win
        name.font = UIFont.systemFont(ofSize: 13)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var death: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.lose
        name.font = UIFont.systemFont(ofSize: 13)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var assistant: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.subtitle
        name.font = UIFont.systemFont(ofSize: 13)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        setUp()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Set up constraints

    private func setUp() {
        self.selectionStyle = .none
        contentView.addSubview(hero)
        contentView.addSubview(gameMode)
        contentView.addSubview(duration)
        contentView.addSubview(kill)
        contentView.addSubview(death)
        contentView.addSubview(assistant)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            hero.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            hero.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            hero.heightAnchor.constraint(equalToConstant: 30),
            hero.widthAnchor.constraint(equalToConstant: 50),

            gameMode.leadingAnchor.constraint(equalTo: hero.trailingAnchor),
            gameMode.trailingAnchor.constraint(equalTo: duration.leadingAnchor),
            gameMode.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            duration.trailingAnchor.constraint(equalTo: kill.leadingAnchor),
            duration.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            duration.widthAnchor.constraint(equalToConstant: 60),
            duration.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            duration.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),

            kill.trailingAnchor.constraint(equalTo: death.leadingAnchor),
            kill.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            kill.widthAnchor.constraint(equalToConstant: 30),

            death.trailingAnchor.constraint(equalTo: assistant.leadingAnchor),
            death.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            death.widthAnchor.constraint(equalToConstant: 30),

            assistant.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            assistant.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            assistant.widthAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = spacing
    }
}

extension RecentMatchesHeader: PlayerInfoCellConfigurable {
    func configure(with data: PlayerTableViewCellData) {
        hero.text = "Hero"
        gameMode.text = "Game mode"
        duration.text = "Duration, min"
        kill.text = "K"
        death.text = "D"
        assistant.text = "A"
    }
}
