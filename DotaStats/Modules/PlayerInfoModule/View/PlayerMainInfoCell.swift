import UIKit

final class PlayerMainInfoCell: UITableViewCell {
    static let reuseIdentifier = "PlayerMainInfoCell"

    // MARK: - Properties

    private lazy var avatar: CachedImageView = {
        let image = CachedImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private lazy var name: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 30)
        name.textAlignment = .center
        name.numberOfLines = 1
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()

    private lazy var rank: UILabel = {
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

    func setUp() {
        self.selectionStyle = .none
        contentView.addSubview(avatar)
        contentView.addSubview(name)
        contentView.addSubview(rank)
    }

    func setUpConstraints() {
        let avatarWidth = CGFloat(150)
        avatar.layer.cornerRadius = avatarWidth / 2
        NSLayoutConstraint.activate([
            avatar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatar.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            avatar.widthAnchor.constraint(equalToConstant: avatarWidth),
            avatar.heightAnchor.constraint(equalToConstant: avatarWidth),

            name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 10),
            name.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            name.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),

            rank.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            rank.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            rank.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            rank.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            rank.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

extension PlayerMainInfoCell: PlayerInfoCellConfigurable {
    func configure(with data: PlayerTableViewCellData) {
        switch data {
        case .playerMainInfo(let data):
            name.text = data.name
            rank.text = String("🏆 \(data.leaderboardRank)")
            avatar.setImage(
                with: data.avatar ?? "https://mobimg.b-cdn.net/v3/fetch/54/54bb741fd881313da79ec7d7f648fe9d.jpeg"
            )
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
