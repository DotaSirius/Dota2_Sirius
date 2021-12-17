import UIKit

final class PlayerMatchCell: UITableViewCell {
    static let reuseIdentifier = "PlayerMatchCell"

    // MARK: - Properties

    private lazy var heroImageView: CachedImageView = {
        let image = CachedImageView()
        image.backgroundColor = .gray
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var gameModeLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var skillLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.subtitle
        name.font = UIFont.systemFont(ofSize: 15)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var gameSkillLabel: UIStackView = {
        let gameSkill = UIStackView()
        createStackView(stackView: gameSkill, axis: .vertical, spacing: 0)
        gameSkill.translatesAutoresizingMaskIntoConstraints = false
        return gameSkill
    }()

    private lazy var winLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var durationLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var killLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.lose
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var deathLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.win
        name.font = UIFont.systemFont(ofSize: 20)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var assistantLabel: UILabel = {
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

    private func setUp() {
        self.selectionStyle = .none
        gameSkillLabel.addArrangedSubview(gameModeLabel)
        gameSkillLabel.addArrangedSubview(skillLabel)
        contentView.addSubview(gameSkillLabel)
        contentView.addSubview(heroImageView)
        contentView.addSubview(winLabel)
        contentView.addSubview(durationLabel)
        contentView.addSubview(killLabel)
        contentView.addSubview(deathLabel)
        contentView.addSubview(assistantLabel)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            heroImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: 30),
            heroImageView.widthAnchor.constraint(equalToConstant: 50),

            assistantLabel.trailingAnchor.constraint(
                equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                constant: -5
            ),
            assistantLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            assistantLabel.widthAnchor.constraint(equalToConstant: 30),

            deathLabel.trailingAnchor.constraint(equalTo: assistantLabel.leadingAnchor),
            deathLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            deathLabel.widthAnchor.constraint(equalToConstant: 30),

            killLabel.trailingAnchor.constraint(equalTo: deathLabel.leadingAnchor),
            killLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            killLabel.widthAnchor.constraint(equalToConstant: 30),

            durationLabel.trailingAnchor.constraint(equalTo: killLabel.leadingAnchor),
            durationLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            durationLabel.widthAnchor.constraint(equalToConstant: 60),

            winLabel.trailingAnchor.constraint(equalTo: durationLabel.leadingAnchor),
            winLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            winLabel.widthAnchor.constraint(equalToConstant: 30),

            gameSkillLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            gameSkillLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            gameSkillLabel.leadingAnchor.constraint(equalTo: heroImageView.trailingAnchor),
            gameSkillLabel.trailingAnchor.constraint(equalTo: winLabel.leadingAnchor)
        ])
    }

    private func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
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
            heroImageView.setImage(with: "https://api.opendota.com/apps/dota2/images/heroes/slardar_full.png")
            gameModeLabel.text = String(data.gameMode)
            skillLabel.text = data.skill
            winLabel.text = data.win ? "🏆" : ""
            durationLabel.text = String(data.duration)
            killLabel.text = String(data.kills)
            deathLabel.text = String(data.deaths)
            assistantLabel.text = String(data.assists)
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}