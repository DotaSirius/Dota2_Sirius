import Foundation
import UIKit

class SearchPlayerTableViewCell: UITableViewCell {
    // Константы для констрейнтов
    private enum Margin {
        static let topMargin: CGFloat = 5
        static let bottomMargin: CGFloat = -5
        static let leadingMargin: CGFloat = 20
        static let trailingMargin: CGFloat = -50
    }
    
    // объявляю переменные
    lazy var avatarImage = UIImageView()
    lazy var nickname: UILabel = {
        let nickname = UILabel()
        nickname.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        nickname.textColor = .white
        return nickname
    }()
    
    var raiting: UILabel = {
        let raiting = UILabel()
        raiting.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        raiting.textColor = .white
        return raiting
    }()
    
    static let reuseIdentifier = "PlayerCell"
    private let colorPalette = ColorPalette()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    // Здесь я творю всю магию с ячейками
    private func setup() {
        contentView.addSubview(avatarImage)
        contentView.addSubview(nickname)
        contentView.addSubview(raiting)
        
        nickname.translatesAutoresizingMaskIntoConstraints = false
        avatarImage.translatesAutoresizingMaskIntoConstraints = false
        raiting.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: Margin.topMargin),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Margin.leadingMargin),
            avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Margin.bottomMargin),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor),
            
            nickname.centerYAnchor.constraint(equalTo: centerYAnchor),
            nickname.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: Margin.leadingMargin),
            
            raiting.centerYAnchor.constraint(equalTo: centerYAnchor),
            raiting.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Margin.trailingMargin),
        ])
    }
    
    func configurePlayer(_ newAvatarImage: UIImage, _ newNickname: String, _ newRatingImage: String) {
        avatarImage.image = newAvatarImage
        nickname.text = newNickname
        raiting.text = newRatingImage
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("commit #31")
    }
}
