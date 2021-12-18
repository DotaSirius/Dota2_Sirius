import UIKit

final class MatchPlayerCell: UITableViewCell {
    static let reuseIdentifier = "MatchPlayerCell"
    let inset: CGFloat = 16
    let smallInset: CGFloat = 8
    let widthConstant: CGFloat = 30

    private lazy var heroImageView: CachedImageView = {
        let image = CachedImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    private lazy var playerRankNameStack: UIStackView = {
        let playerRankNameStack = UIStackView()
        createStackView(stackView: playerRankNameStack, axis: .vertical, spacing: 8)
        playerRankNameStack.translatesAutoresizingMaskIntoConstraints = false
        return playerRankNameStack
    }()

    private lazy var playerNameLabel: UILabel = {
        let playerNameLabel = UILabel()
        playerNameLabel.textColor = ColorPalette.mainText
        playerNameLabel.font = UIFont.systemFont(ofSize: 17) // изменить шрифт
        playerNameLabel.textAlignment = .left
        playerNameLabel.numberOfLines = 2
        playerNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerNameLabel
    }()

    private lazy var playerRankLabel: UILabel = {
        let playerRankLabel = UILabel()
        playerRankLabel.textColor = ColorPalette.subtitle
        playerRankLabel.font = UIFont.systemFont(ofSize: 17) // изменить шрифт
        playerRankLabel.textAlignment = .center
        playerRankLabel.numberOfLines = 3
        playerRankLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerRankLabel
    }()

    private lazy var playerKillsLabel: UILabel = {
        let playerKillsLabel = UILabel()
        playerKillsLabel.textColor = ColorPalette.win
        playerKillsLabel.font = UIFont.systemFont(ofSize: 17)
        playerKillsLabel.textAlignment = .center
        playerKillsLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerKillsLabel
    }()

    private lazy var playerDeathsLabel: UILabel = {
        let playerDeathsLabel = UILabel()
        playerDeathsLabel.textColor = ColorPalette.lose
        playerDeathsLabel.font = UIFont.systemFont(ofSize: 17)
        playerDeathsLabel.textAlignment = .center
        playerDeathsLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerDeathsLabel
    }()

    private lazy var playerAssitsLabel: UILabel = {
        let playerAssitsLabel = UILabel()
        playerAssitsLabel.textColor = ColorPalette.subtitle
        playerAssitsLabel.font = UIFont.systemFont(ofSize: 17)
        playerAssitsLabel.textAlignment = .center
        playerAssitsLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerAssitsLabel
    }()

    private lazy var playerGoldLabel: UILabel = {
        let playerGoldLabel = UILabel()
        playerGoldLabel.textColor = ColorPalette.accent
        playerGoldLabel.font = UIFont.systemFont(ofSize: 17)
        playerGoldLabel.textAlignment = .center
        playerGoldLabel.translatesAutoresizingMaskIntoConstraints = false
        return playerGoldLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup() {
        [
            heroImageView,
            playerRankNameStack,
            playerGoldLabel,
            playerAssitsLabel,
            playerDeathsLabel,
            playerKillsLabel
        ].forEach {
            contentView.addSubview($0)
        }

        [playerNameLabel,
         playerRankLabel].forEach {
            playerRankNameStack.addArrangedSubview($0)
        }
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            heroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: smallInset),
            heroImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            heroImageView.widthAnchor.constraint(equalToConstant: 72),
            heroImageView.heightAnchor.constraint(equalToConstant: 54),

            playerRankNameStack.leadingAnchor.constraint(equalTo: heroImageView.trailingAnchor, constant: smallInset),
            playerRankNameStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: smallInset),
            playerRankNameStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            playerRankNameStack.trailingAnchor.constraint(
                equalTo: playerKillsLabel.leadingAnchor, constant: -smallInset
            ),

            playerGoldLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            playerGoldLabel.centerYAnchor.constraint(equalTo: playerRankNameStack.centerYAnchor),
            playerGoldLabel.widthAnchor.constraint(equalToConstant: widthConstant),

            playerAssitsLabel.trailingAnchor.constraint(equalTo: playerGoldLabel.leadingAnchor, constant: -smallInset),
            playerAssitsLabel.widthAnchor.constraint(equalTo: playerGoldLabel.widthAnchor),
            playerAssitsLabel.centerYAnchor.constraint(equalTo: playerRankNameStack.centerYAnchor),

            playerDeathsLabel.trailingAnchor.constraint(
                equalTo: playerAssitsLabel.leadingAnchor, constant: -smallInset
            ),
            playerDeathsLabel.widthAnchor.constraint(equalTo: playerGoldLabel.widthAnchor),
            playerDeathsLabel.centerYAnchor.constraint(equalTo: playerRankNameStack.centerYAnchor),

            playerKillsLabel.trailingAnchor.constraint(equalTo: playerDeathsLabel.leadingAnchor, constant: -smallInset),
            playerKillsLabel.widthAnchor.constraint(equalTo: playerGoldLabel.widthAnchor),
            playerKillsLabel.centerYAnchor.constraint(equalTo: playerRankNameStack.centerYAnchor)
        ])
    }

    func createStackView(stackView: UIStackView, axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        stackView.axis = axis
        stackView.distribution = .equalSpacing
        stackView.alignment = .leading
        stackView.spacing = spacing
    }
}

extension MatchPlayerCell: DetailedMatchInfoCellConfigurable {
    func configure(with data: MatchTableViewCellData) {
        switch data.type {
        case .matchPlayerInfo(let data):
            playerNameLabel.text = data.playerNameLabelText
            playerDeathsLabel.text = data.playerDeathsText
            playerRankLabel.text = data.playerRankText
            playerKillsLabel.text = data.playerKillsText
            playerAssitsLabel.text = data.playerAssitsText
            playerGoldLabel.text = data.playerGoldText
            heroImageView.setImage(with: data.playerImage)
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
