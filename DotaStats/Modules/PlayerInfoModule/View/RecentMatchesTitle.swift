import UIKit

final class RecentMatchesTitle: UITableViewCell {
    static let reuseIdentifier = "RecentMatchesTitle"

    // MARK: - Properties

    private lazy var name: UILabel = {
        let name = UILabel()
        name.textColor = ColorPalette.mainText
        name.font = UIFont.systemFont(ofSize: 20)
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
        contentView.addSubview(name)
    }

    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            name.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            name.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension RecentMatchesTitle: PlayerInfoCellConfigurable {
    func configure(with data: PlayerTableViewCellData) {
        name.text = "Recent matches"
    }
}
