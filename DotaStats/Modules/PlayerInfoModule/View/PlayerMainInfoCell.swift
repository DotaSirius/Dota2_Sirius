import UIKit

final class PlayerMainInfoCell: UITableViewCell {
    static let reuseIdentifier = "PlayerMainInfoCell"

    private enum Constant {
        static let avatarWidth: CGFloat = 150
        static let spacing: CGFloat = 10
    }
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
        contentView.addSubview(avatar)
        contentView.addSubview(nameLabel)
    }

    private func setUpConstraints() {
        avatar.layer.cornerRadius = Constant.avatarWidth / 2
        NSLayoutConstraint.activate([
            avatar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor,
                                        constant: Constant.spacing),
            avatar.widthAnchor.constraint(equalToConstant: Constant.avatarWidth),
            avatar.heightAnchor.constraint(equalToConstant: Constant.avatarWidth),

            nameLabel.topAnchor.constraint(equalTo: avatar.bottomAnchor,
                                           constant: Constant.spacing),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor,
                                               constant: Constant.spacing),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,
                                                constant: -Constant.spacing),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.spacing)
        ])
    }
}

extension PlayerMainInfoCell: PlayerInfoCellConfigurable {
    func configure(with data: PlayerTableViewCellData) {
        switch data {
        case .playerMainInfo(let data):
            nameLabel.text = data.name
            avatar.setImage(
                with: data.avatarUrl ??
                "https://offers-api.agregatoreat.ru/api/file/649bf689-2165-46b1-8e5c-0ec89a54c05f"
            )
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
