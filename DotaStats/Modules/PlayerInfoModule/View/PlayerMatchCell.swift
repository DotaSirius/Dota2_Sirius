import UIKit

final class PlayerMatchCell: UITableViewCell {
    static let reuseIdentifier = "PlayerMatchCell"

    // MARK: - Properties

    private lazy var hero: CachedImageView = {
        let image = CachedImageView()
        image.backgroundColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var gameMode: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var skill: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.subtitle
        name.font = UIFont.systemFont(ofSize: 15)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var gameSkill: UIStackView = {
        let gameSkill = UIStackView()
        createStackView(stackView: gameSkill, axis: .vertical, spacing: 0)
        gameSkill.translatesAutoresizingMaskIntoConstraints = false
        return gameSkill
    }()

    private lazy var win: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var duration: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var kill: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.lose
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var death: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.win
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var assistant: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.subtitle
        name.font = UIFont.systemFont(ofSize: 20)
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

    func setUp() {
        self.selectionStyle = .none
        gameSkill.addArrangedSubview(gameMode)
        gameSkill.addArrangedSubview(skill)
        contentView.addSubview(gameSkill)
        contentView.addSubview(hero)
        contentView.addSubview(win)
        contentView.addSubview(duration)
        contentView.addSubview(kill)
        contentView.addSubview(death)
        contentView.addSubview(assistant)
    }

    func setUpConstraints() {
        NSLayoutConstraint.activate([
            hero.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            hero.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            hero.heightAnchor.constraint(equalToConstant: 30),
            hero.widthAnchor.constraint(equalToConstant: 50),

            assistant.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -5),
            assistant.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            assistant.widthAnchor.constraint(equalToConstant: 30),

            death.trailingAnchor.constraint(equalTo: assistant.leadingAnchor),
            death.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            death.widthAnchor.constraint(equalToConstant: 30),

            kill.trailingAnchor.constraint(equalTo: death.leadingAnchor),
            kill.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            kill.widthAnchor.constraint(equalToConstant: 30),

            duration.trailingAnchor.constraint(equalTo: kill.leadingAnchor),
            duration.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            duration.widthAnchor.constraint(equalToConstant: 60),

            win.trailingAnchor.constraint(equalTo: duration.leadingAnchor),
            win.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            win.widthAnchor.constraint(equalToConstant: 30),

            gameSkill.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            gameSkill.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            gameSkill.leadingAnchor.constraint(equalTo: hero.trailingAnchor),
            gameSkill.trailingAnchor.constraint(equalTo: win.leadingAnchor)
        ])
    }

    func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = spacing
    }
}

extension PlayerMatchCell: PlayerInfoCellConfigurable {
    func configure(with data: PlayerTableViewCellData) {
        switch data {
        case .playerMatch(let data):
            hero.setImage(with: "https://api.opendota.com/apps/dota2/images/heroes/slardar_full.png")
            gameMode.text = String(data.gameMode)
            skill.text = data.skill
            win.text = data.win ? "🏆" : ""
            duration.text = String(data.duration)
            kill.text = String(data.kills)
            death.text = String(data.deaths)
            assistant.text = String(data.assists)
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}