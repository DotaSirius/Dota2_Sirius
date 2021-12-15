import UIKit

final class ProPlayerCell: UITableViewCell {
    static let identifier = "ProPlayerCell"
    
    private enum Constant {
        static let spacing: CGFloat = 10
        static let nameFontSize: CGFloat = 17
        static let additionalInfoFontSize: CGFloat = 13
    }
    
    private lazy var avatar: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "players")
        imageView.image = image
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = avatarWidth / 2
        imageView.backgroundColor = .lightGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.nameFontSize, weight: .bold)
        label.textColor = ColorPalette.text
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var additionalInfo: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Constant.additionalInfoFontSize, weight: .bold)
        label.textColor = ColorPalette.subtitle
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameLabel, additionalInfo])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        return stack
    }()

    private var avatarWidth: CGFloat {
        round(contentView.frame.size.width / 6)
    }
    
    func configure(with title: String = "Dendi",
                   image: UIImage? = nil,
                   additional: String = "UA, NAVI",
                   isEven: Bool) {
        nameLabel.text = title
        additionalInfo.text = additional
        contentView.backgroundColor = isEven ? ColorPalette.alternativeBackground : ColorPalette.mainBackground
        setup()
    }
    
    private func setup() {
        contentView.addSubview(avatar)
        
        let bottomConstraint = avatar.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constant.spacing)
        bottomConstraint.priority = UILayoutPriority(rawValue: 300)
        bottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            avatar.widthAnchor.constraint(equalToConstant: avatarWidth),
            avatar.heightAnchor.constraint(equalToConstant: avatarWidth),
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constant.spacing),
            avatar.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.spacing),
           
            stackView.leadingAnchor.constraint(equalTo: avatar.trailingAnchor, constant: Constant.spacing),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constant.spacing),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
