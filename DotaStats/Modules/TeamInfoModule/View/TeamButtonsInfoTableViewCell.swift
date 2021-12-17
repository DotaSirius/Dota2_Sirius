import UIKit

final class TeamButtonsInfoTableViewCell: UITableViewCell {
    // MARK: - Properties

    static let reuseIdentifier = "TeamButtonsInfoTableViewCell"

    private lazy var matchesView: UIButton = {
        let label = UIButton()
        label.backgroundColor = ColorPalette.alternativeBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setTitleColor(ColorPalette.mainText, for: .normal)
        label.addTarget(self, action: #selector(chooseTitle), for: .touchUpInside)
        return label
    }()

    private lazy var playersView: UIButton = {
        let label = UIButton()
        label.backgroundColor = ColorPalette.alternativeBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setTitleColor(ColorPalette.mainText, for: .normal)
        label.addTarget(self, action: #selector(chooseTitle), for: .touchUpInside)
        return label
    }()

    private lazy var herousView: UIButton = {
        let label = UIButton()
        label.backgroundColor = ColorPalette.alternativeBackground
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setTitleColor(ColorPalette.mainText, for: .normal)
        label.addTarget(self, action: #selector(chooseTitle), for: .touchUpInside)
        return label
    }()

    @objc
    private func chooseTitle(sender: UIButton) {
        if matchesView != sender {
            matchesView.setTitleColor(ColorPalette.mainText, for: .normal)
        }
        if playersView != sender {
            playersView.setTitleColor(ColorPalette.mainText, for: .normal)
        }
        if herousView != sender {
            herousView.setTitleColor(ColorPalette.mainText, for: .normal)
        }
        sender.setTitleColor(ColorPalette.accent, for: .normal)
    }

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
        backgroundColor = ColorPalette.alternativeBackground

        contentView.addSubview(matchesView)
        contentView.addSubview(playersView)
        contentView.addSubview(herousView)

        NSLayoutConstraint.activate([
            playersView.centerYAnchor.constraint(equalTo: centerYAnchor),
            playersView.centerXAnchor.constraint(equalTo: centerXAnchor),
            playersView.heightAnchor.constraint(equalToConstant: 30),
            playersView.widthAnchor.constraint(equalToConstant: 100),

            matchesView.centerYAnchor.constraint(equalTo: centerYAnchor),
            matchesView.trailingAnchor.constraint(equalTo: centerXAnchor, constant: -70),
            matchesView.heightAnchor.constraint(equalToConstant: 30),
            matchesView.widthAnchor.constraint(equalToConstant: 100),

            herousView.centerYAnchor.constraint(equalTo: centerYAnchor),
            herousView.leadingAnchor.constraint(equalTo: centerXAnchor, constant: 70),
            herousView.heightAnchor.constraint(equalToConstant: 30),
            herousView.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}

extension TeamButtonsInfoTableViewCell: DetailedTeamInfoCellConfigurable {
    // MARK: - Cell configuration
    func configure(with data: TeamInfoTableViewCellData) {
        matchesView.setTitle("Matches", for: .normal)
        playersView.setTitle("Players", for: .normal)
        herousView.setTitle("Herous", for: .normal)
    }
}
