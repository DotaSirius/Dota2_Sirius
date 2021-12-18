import Foundation
import UIKit

final class TeamsInfoMatches: UITableViewCell {
    // MARK: - Properties

    static let reuseIdentifier = "TeamsInfoMatches"

    private lazy var number: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    private lazy var results: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    private lazy var duration: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        return label
    }()

    private lazy var enemyImage: CachedImageView = {
        let imageView = CachedImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView

    }()

    private lazy var enemy: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .left
        label.textColor = ColorPalette.mainText
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup constrains

    private func setup() {
        backgroundColor = ColorPalette.mainBackground

        contentView.addSubview(number)
        contentView.addSubview(duration)
        contentView.addSubview(results)
        contentView.addSubview(enemyImage)
        contentView.addSubview(enemy)

        NSLayoutConstraint.activate([
            number.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            number.centerYAnchor.constraint(equalTo: centerYAnchor),
            number.trailingAnchor.constraint(equalTo: duration.leadingAnchor, constant: -22),

            duration.trailingAnchor.constraint(equalTo: results.leadingAnchor, constant: -10),
            duration.centerYAnchor.constraint(equalTo: centerYAnchor),
            duration.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 165),

            results.trailingAnchor.constraint(equalTo: enemyImage.leadingAnchor, constant: -10),
            results.centerYAnchor.constraint(equalTo: centerYAnchor),
            results.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 240),

            enemyImage.trailingAnchor.constraint(equalTo: enemy.leadingAnchor, constant: -5),
            enemyImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            enemyImage.widthAnchor.constraint(equalToConstant: 70),

            enemy.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            enemy.centerYAnchor.constraint(equalTo: centerYAnchor),
            enemy.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 320)

        ])
    }
}

extension TeamsInfoMatches: DetailedTeamInfoCellConfigurable {
    // MARK: - Cell configuration

    func configure(with data: TeamInfoTableViewCellData) {
        switch data.type {
        case .teamsInfoMatches(let date):
            number.text = date.matches
            duration.text = date.duration
            results.text = date.result ? "Win" : "Lose"
            results.textColor = date.result ? ColorPalette.win : ColorPalette.lose
            enemy.text = date.enemy
            enemyImage.setImage(with: date.image)
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
