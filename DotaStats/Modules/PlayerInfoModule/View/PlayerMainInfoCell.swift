import UIKit

final class PlayerMainInfoCell: UITableViewCell {
    static let reuseIdentifier = "PlayerMainInfoCell"

    // MARK: - Properties

    private lazy var avatar: CachedImageView = {
        let image = CachedImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var nameLabel: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 30)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var rankLabel: UILabel = {
        let rank = UILabel()
        rank.textColor = ColorPalette.mainText
        rank.font = UIFont.systemFont(ofSize: 20)
        rank.textAlignment = .center
        rank.numberOfLines = 1
        rank.translatesAutoresizingMaskIntoConstraints = false
        return rank
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
        selectionStyle = .none
        contentView.addSubview(avatar)
        contentView.addSubview(nameLabel)
        contentView.addSubview(rankLabel)
    }

    private func setUpConstraints() {
        let avatarWidth = CGFloat(150)
        avatar.layer.cornerRadius = avatarWidth / 2
        NSLayoutConstraint.activate([
            avatar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatar.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            avatar.widthAnchor.constraint(equalToConstant: avatarWidth),
            avatar.heightAnchor.constraint(equalToConstant: avatarWidth),

            nameLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),

            rankLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            rankLabel.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            rankLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            rankLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension PlayerMainInfoCell: PlayerInfoCellConfigurable {
    func configure(with data: PlayerTableViewCellData) {
        switch data {
        case .playerMainInfo(let data):
            nameLabel.text = data.name
            rankLabel.text = String("🏆 \(data.leaderboardRank)")
            avatar.setImage(
                with: data.avatarUrl ??
                "https://offers-api.agregatoreat.ru/api/file/649bf689-2165-46b1-8e5c-0ec89a54c05f"
            )
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
