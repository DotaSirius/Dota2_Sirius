import UIKit

final class PlotGpmTableViewCell: UITableViewCell {

    static let reuseIdentifier = "PlotGpmTableViewCell"
    let topInset: CGFloat = 32
    let smallInset: CGFloat = 8

    private lazy var plot : PlotGmpView = {
        let plot = PlotGmpView(plotLines: [],
                               gridVerLines: CAShapeLayer(),
                               gridHorLines: CAShapeLayer(),
                               width: 0,
                               height: 0)
        return plot
    }()

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpScrollView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpScrollView() {
        contentView.addSubview(scrollView)

        scrollView.contentSize = CGSize(width: plot.bounds.width, height: plot.bounds.height)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80),
            scrollView.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: 220)
        ])
    }
}

extension PlotGpmTableViewCell:  DetailedMatchInfoCellConfigurable {
    func configure(with data: MatchTableViewCellData) {
        switch data.type {
        case .plotGpmInfo(let data):
            print(data.heroId)
            
        default : assertionFailure("Произошла ошибка при заполнении ячейки данными")
       }
    }
}
