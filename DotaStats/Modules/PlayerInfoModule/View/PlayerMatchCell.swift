import UIKit

final class PlayerMatchCell: UITableViewCell {
    static let reuseIdentifier = "PlayerMatchCell"

    private enum Constant {
        static let spacing: CGFloat = 10
        static let heroImageWidth: CGFloat = 60
        static let heroImageHeight: CGFloat = 40
    }
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
        name.font = UIFont.systemFont(ofSize: 17)
        name.textAlignment = .left
        name.numberOfLines = 2
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var skillLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.subtitle
        name.font = UIFont.systemFont(ofSize: 13)
        name.textAlignment = .left
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
        name.font = UIFont.systemFont(ofSize: 17)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var durationLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 17)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var killLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.win
        name.font = UIFont.systemFont(ofSize: 17)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var deathLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.lose
        name.font = UIFont.systemFont(ofSize: 17)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var assistantLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.subtitle
        name.font = UIFont.systemFont(ofSize: 17)
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
            heroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: Constant.spacing),
            heroImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: Constant.heroImageHeight),
            heroImageView.widthAnchor.constraint(equalToConstant: Constant.heroImageWidth),

            gameSkillLabel.leadingAnchor.constraint(equalTo: heroImageView.trailingAnchor,
                                                    constant: Constant.spacing),
            gameSkillLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                constant: Constant.spacing),
            gameSkillLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                   constant: -Constant.spacing),

            winLabel.leadingAnchor.constraint(equalTo: gameSkillLabel.trailingAnchor,
                                              constant: Constant.spacing),
            winLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            assistantLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -Constant.spacing),
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
            durationLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
    }

    private func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = spacing
    }
}

extension PlayerMatchCell: PlayerInfoCellConfigurable {
    func configure(with data: PlayerTableViewCellData) {
        switch data {
        case .playerMatch(let data):
            heroImageView.setImage(with: data.heroImage)
            gameModeLabel.text = data.gameMode.capitalizingFirstLetter()
            skillLabel.text = data.skill
            let isUnknownSkill = data.skill == "Unknown skill"
            skillLabel.layer.opacity = isUnknownSkill ? 0.5 : 1
            winLabel.text = data.win ? "🏆" : ""
            durationLabel.text = String(data.duration)
            killLabel.text = String(data.kills)
            deathLabel.text = String(data.deaths)
            assistantLabel.text = String(data.assists)
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
