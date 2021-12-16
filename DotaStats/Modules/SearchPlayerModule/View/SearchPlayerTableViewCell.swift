import UIKit

final class SearchPlayerTableViewCell: UITableViewCell {
    // MARK: Margins for items in TableViewCell

    private enum Margin {
        static let topMargin: CGFloat = 11
        static let bottomMargin: CGFloat = -11
        static let leadingMargin: CGFloat = 20
        static let trailingMargin: CGFloat = -25
    }

    private lazy var avatarImageView: CachedImageView = {
        let view = CachedImageView()
        view.layer.cornerRadius = layer.frame.height / 2
        view.sizeToFit()
        return view
    }()

    private lazy var nicknameLabel: UILabel = {
        let nickname = UILabel()
        nickname.layer.frame.size.width = contentView.layer.frame.size.width/2
        nickname.lineBreakMode = .byTruncatingTail
        nickname.numberOfLines = 1
        nickname.font = .systemFont(ofSize: 17)
        nickname.textColor = ColorPalette.mainText
        nickname.translatesAutoresizingMaskIntoConstraints = false
        return nickname
    }()

    private lazy var timeMatchLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 17)
        view.numberOfLines = 2
        view.textAlignment = .center
        view.textColor = ColorPalette.mainText
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    static let reuseIdentifier = "PlayerCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellsConstrains()
    }

    // MARK: setupConstrains of items in TableViewCell

    private func setupCellsConstrains() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(timeMatchLabel)
        contentView.addSubview(nicknameLabel)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        let constrainNicknameToTimeMatch = nicknameLabel.trailingAnchor.constraint(equalTo: timeMatchLabel.leadingAnchor, constant: Margin.trailingMargin)
//        constrainNicknameToTimeMatch.priority = .defaultLow
        nicknameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: Margin.topMargin),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.leadingMargin),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.bottomMargin),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

            nicknameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nicknameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: Margin.leadingMargin),
            constrainNicknameToTimeMatch,
            
            timeMatchLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeMatchLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.trailingMargin),
            timeMatchLabel.widthAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    func configurePlayer(newAvatarImage: String, newNickname: String, newTimeMatch: String?) {
        avatarImageView.setImage(with: newAvatarImage)
        nicknameLabel.text = newNickname
        if newTimeMatch != " - " {
            guard let unwrappedTime = newTimeMatch else {
                return
            }
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
            let date = formatter.date(from: unwrappedTime)
            formatter.dateFormat = "EEEE, MMM d, yyyy"
            var labelText = formatter.string(from: date!)
            labelText.insert("\n", at: labelText.firstIndex(of: ",")!)
            labelText.remove(at: labelText.firstIndex(of: ",")!)
            timeMatchLabel.text = labelText
        } else {
            timeMatchLabel.text = " - "
        }
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("commit #31")
    }
}
