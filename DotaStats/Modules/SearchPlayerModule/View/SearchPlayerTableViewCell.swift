import UIKit

final class SearchPlayerTableViewCell: UITableViewCell {
    // MARK: Margins for items in TableViewCell

    private enum Margin {
        static let topMargin: CGFloat = 5
        static let bottomMargin: CGFloat = -5
        static let leadingMargin: CGFloat = 20
        static let trailingMargin: CGFloat = -50
    }

    private lazy var avatarImage = UIImageView()
    private lazy var nickname: UILabel = {
        let nickname = UILabel()
        nickname.font = .systemFont(ofSize: 17)
        nickname.textColor = ColorPalette.mainText
        nickname.translatesAutoresizingMaskIntoConstraints = false
        return nickname
    }()

    private lazy var timeMatch: UILabel = {
        let rating = UILabel()
        rating.font = .systemFont(ofSize: 17)
        rating.textColor = ColorPalette.mainText
        rating.translatesAutoresizingMaskIntoConstraints = false
        return rating
    }()

    static let reuseIdentifier = "PlayerCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    // MARK: setupConstrains of items in TableViewCell

    private func setup() {
        contentView.addSubview(avatarImage)
        contentView.addSubview(nickname)
        contentView.addSubview(timeMatch)

        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: Margin.topMargin),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.leadingMargin),
            avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.bottomMargin),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor),

            nickname.centerYAnchor.constraint(equalTo: centerYAnchor),
            nickname.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: Margin.leadingMargin),

            timeMatch.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeMatch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.trailingMargin)
        ])
    }

    func configurePlayer(newAvatarImage: UIImage, newNickname: String, newTimeMatch: String) {
        avatarImage.image = newAvatarImage
        nickname.text = newNickname
        timeMatch.text = newTimeMatch
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("commit #31")
    }
}
