import UIKit

final class PlotGpmTableViewCell: UITableViewCell {
    static let reuseIdentifier = "PlotGpmTableViewCell"

    private let scrollView = UIScrollView()
    private let heightOfGmpView: CGFloat = 300
    private var widthOfGmpView: CGFloat = 0

    private var plotLines: [CAShapeLayer] = []
    private var gridVerLines = CAShapeLayer()
    private var gridHorLines = CAShapeLayer()
    private var gmpData: [PlotGpmInfo] = []
    private var maxGold: CGFloat = 1
    private var marksInGoldAxis: [Int] = []

    private lazy var plot: UIView = {
        makePlotView()
    }()

    private lazy var colorButtonsStackView: UIStackView = {
        let buttons = createButtons()
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()

    private lazy var heroNameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var markStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false

        var arrayOfMarksLabels = [UILabel]()

        for mark in marksInGoldAxis.reversed() {
            let label = UILabel()
            label.text = "\(mark)"
            label.textAlignment = .center
            label.textColor = ColorPalette.mainText
            label.backgroundColor = ColorPalette.alternativeBackground
            label.layer.cornerRadius = 5
            label.layer.masksToBounds = true
            label.font = UIFont.systemFont(ofSize: 12)
            label.layer.shadowOpacity = 15
            label.layer.shadowRadius = 15

            stackView.addArrangedSubview(label)
        }
        return stackView
    }()

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpLayout() {
        selectionStyle = .none
        contentView.addSubview(scrollView)
        contentView.addSubview(colorButtonsStackView)
        contentView.addSubview(heroNameLabel)
        contentView.addSubview(markStackView)

        scrollView.addSubview(plot)

        scrollView.isScrollEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: widthOfGmpView, height: heightOfGmpView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 1.25 * heightOfGmpView)
        ])
        NSLayoutConstraint.activate([
            colorButtonsStackView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -30),
            colorButtonsStackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10),
            colorButtonsStackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -10),
            colorButtonsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            heroNameLabel.topAnchor.constraint(equalTo: colorButtonsStackView.bottomAnchor, constant: -50),
            heroNameLabel.centerXAnchor.constraint(
                equalTo: colorButtonsStackView.centerXAnchor),
            heroNameLabel.bottomAnchor.constraint(equalTo: colorButtonsStackView.bottomAnchor, constant: -30)
        ])
        NSLayoutConstraint.activate([
            markStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 14),
            markStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            markStackView.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: heightOfGmpView - 16)
        ])
    }

    private func makePlotView() -> UIView {
        let plotView = UIView(frame: CGRect(x: 0, y: 0,
                                            width: widthOfGmpView, height: heightOfGmpView))
        for line in plotLines {
            plotView.layer.addSublayer(line)
        }
        plotView.layer.addSublayer(gridVerLines)
        plotView.layer.addSublayer(gridHorLines)
        return plotView
    }

    private func setUpLinesAndWidthOfPlot() {
        let space = CGPoint(x: 20, y: -20) // indent left bottom
        let widthOfMinute = (contentView.frame.size.width + 2 * space.x)/16
        let minutesCount = gmpData[0].gmp.count
        let fillColorOfLines = contentView.backgroundColor

        widthOfGmpView = widthOfMinute * CGFloat(minutesCount)

        for data in gmpData {
            maxGold = max(maxGold, CGFloat(data.gmp.max() ?? 1))
        }

        let availableHeightOfGraph = heightOfGmpView + 3 * space.y // + is - in space.y
        let availableHeightOfGrid = heightOfGmpView + 2 * space.y

        let scaledGoldPoints = getScaledGoldT(gmpData: gmpData,
                                              widthOfMinute: widthOfMinute,
                                              height: availableHeightOfGraph,
                                              heightOfGmpView: heightOfGmpView,
                                              maxGold: maxGold,
                                              space: space)

        marksInGoldAxis = getPointsInGoldAxis(maxGold: maxGold)

        let pointsHorLeftGrid = getScaledHorLeft(pointsInGoldAxis: marksInGoldAxis,
                                                 height: availableHeightOfGrid,
                                                 heightOfGmpView: heightOfGmpView,
                                                 maxGold: maxGold,
                                                 space: space)

        let pointsHorRightGrid = getScaledHorRight(pointsInGoldAxis: marksInGoldAxis,
                                                   height: availableHeightOfGrid,
                                                   heightOfGmpView: heightOfGmpView,
                                                   maxGold: maxGold,
                                                   minutesCount: minutesCount,
                                                   space: space,
                                                   widthOfMinute: widthOfMinute)

        let pointdVerBottomGrid = getScaledVerBottom(minutesCount: minutesCount,
                                                     widthOfMinute: widthOfMinute,
                                                     heightOfGmpView: heightOfGmpView,
                                                     space: space)

        let pointdVerTopGrid = getScaledVerTop(minutesCount: minutesCount,
                                               height: availableHeightOfGrid,
                                               heightOfGmpView: heightOfGmpView,
                                               space: space,
                                               maxGold: maxGold,
                                               widthOfMinute: widthOfMinute,
                                               pointsInGoldAxis: marksInGoldAxis)

        gridHorLines = getHorGridLines(pointsHorLeft: pointsHorLeftGrid,
                                       pointsHorRight: pointsHorRightGrid,
                                       fillColor: fillColorOfLines)

        gridVerLines = getVertGridLines(pointsVertBottom: pointdVerBottomGrid,
                                        pointsVertTop: pointdVerTopGrid,
                                        fillColor: fillColorOfLines)

        plotLines = getPlotLines(form: scaledGoldPoints,
                                 gmpData: gmpData,
                                 fillColor: fillColorOfLines)
    }

    private func createButtons() -> [UIButton] {
        var buttons = [UIButton]()

        for i in 0..<gmpData.count {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            button.backgroundColor = gmpData[i].color
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor(ciColor: .gray).cgColor
            button.layer.cornerRadius = button.frame.width/2
            button.tag = i
            button.addTarget(nil, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            buttons.append(button)
        }
        return buttons
    }

    @objc private func buttonAction(sender: UIButton) {
        let player = gmpData[sender.tag]
        heroNameLabel.text = player.heroName
        heroNameLabel.textColor = player.color
        heroNameLabel.textAlignment = .center
    }

    private func getScaledGoldT(gmpData: [PlotGpmInfo],
                                widthOfMinute: CGFloat,
                                height: CGFloat,
                                heightOfGmpView: CGFloat,
                                maxGold: CGFloat,
                                space: CGPoint) -> [[CGPoint]]
    {
        let multX = widthOfMinute
        let multY = height/maxGold
        var res = [[CGPoint]]()
        for data in gmpData {
            var newArray = [CGPoint]()
            let array = data.gmp
            for i in 0..<array.count {
                let scaledPoint = CGPoint(x: CGFloat(i) * multX,
                                          y: heightOfGmpView - CGFloat(array[i]) * multY)
                newArray.append(scaledPoint.add(space))
            }
            res.append(newArray)
        }
        return res
    }

    private func getPointsInGoldAxis(maxGold: CGFloat) -> [Int] {
        let maxMark = maxGold.round()
        print(maxMark)
        let multipliyer = maxMark/4
        var array = [Int]()
        for i in 0 ... 4 {
            array.append(i * multipliyer)
        }

        return array
    }

    private func getScaledHorLeft(pointsInGoldAxis points: [Int],
                                  height: CGFloat,
                                  heightOfGmpView: CGFloat,
                                  maxGold: CGFloat,
                                  space: CGPoint) -> [CGPoint]
    {
        let multY = height/maxGold
        var res = [CGPoint]()
        for i in 0..<points.count {
            let scaledPoint = CGPoint(x: 0,
                                      y: heightOfGmpView - CGFloat(points[i]) * multY)
            res.append(scaledPoint.add(space))
        }

        return res
    }

    private func getScaledHorRight(pointsInGoldAxis points: [Int],
                                   height: CGFloat,
                                   heightOfGmpView: CGFloat,
                                   maxGold: CGFloat,
                                   minutesCount: Int,
                                   space: CGPoint,
                                   widthOfMinute: CGFloat) -> [CGPoint]
    {
        let multY = height/maxGold
        let x = CGFloat(minutesCount - 1) * widthOfMinute
        var res = [CGPoint]()
        for i in 0..<points.count {
            let scaledPoint = CGPoint(x: x,
                                      y: heightOfGmpView - CGFloat(points[i]) * multY)
            res.append(scaledPoint.add(space))
        }

        return res
    }

    private func getScaledVerBottom(minutesCount: Int,
                                    widthOfMinute: CGFloat,
                                    heightOfGmpView: CGFloat,
                                    space: CGPoint) -> [CGPoint]
    {
        let y: CGFloat = heightOfGmpView
        var res = [CGPoint]()
        for i in 0..<minutesCount where i % 2 == 0 {
            let scaledPoint = CGPoint(x: widthOfMinute * CGFloat(i),
                                      y: y)
            res.append(scaledPoint.add(space))
        }
        // for last odd
        let scaledPoint = CGPoint(x: widthOfMinute * CGFloat(minutesCount - 1),
                                  y: y)
        res.append(scaledPoint.add(space))

        return res
    }

    private func getScaledVerTop(minutesCount: Int,
                                 height: CGFloat,
                                 heightOfGmpView: CGFloat,
                                 space: CGPoint,
                                 maxGold: CGFloat,
                                 widthOfMinute: CGFloat,
                                 pointsInGoldAxis points: [Int]) -> [CGPoint]
    {
        let multY = height/maxGold
        let y: CGFloat = heightOfGmpView - CGFloat(points.last ?? 0) * multY

        var res = [CGPoint]()
        for i in 0..<minutesCount where i % 2 == 0 {
            let scaledPoint = CGPoint(x: widthOfMinute * CGFloat(i),
                                      y: y)
            res.append(scaledPoint.add(space))
        }

        // for last odd
        let scaledPoint = CGPoint(x: widthOfMinute * CGFloat(minutesCount - 1),
                                  y: y)
        res.append(scaledPoint.add(space))

        return res
    }

    private func getPlotLines(form arrays: [[CGPoint]],
                              gmpData: [PlotGpmInfo],
                              fillColor: UIColor?) -> [CAShapeLayer]
    {
        var lines = [CAShapeLayer]()

        for i in 0..<arrays.count {
            let arr = arrays[i]
            let line = CAShapeLayer()
            let linePath = UIBezierPath()
            linePath.move(to: arr.first ?? .zero)

            for point in arr {
                linePath.addLine(to: point)
            }

            line.path = linePath.cgPath
            line.strokeColor = gmpData[i].color.cgColor
            line.lineWidth = 2
            line.lineJoin = .round
            line.fillColor = fillColor?.cgColor

            lines.append(line)
        }

        return lines
    }

    private func getVertGridLines(pointsVertBottom: [CGPoint],
                                  pointsVertTop: [CGPoint],
                                  fillColor: UIColor?) -> CAShapeLayer
    {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()

        for i in 0..<pointsVertBottom.count {
            linePath.move(to: pointsVertBottom[i])
            linePath.addLine(to: pointsVertTop[i])
        }

        line.path = linePath.cgPath
        line.strokeColor = UIColor(ciColor: .gray).cgColor
        line.lineWidth = 0.5
        line.lineJoin = .round
        line.fillColor = fillColor?.cgColor

        return line
    }

    private func getHorGridLines(pointsHorLeft: [CGPoint],
                                 pointsHorRight: [CGPoint],
                                 fillColor: UIColor?) -> CAShapeLayer
    {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()

        for i in 0..<pointsHorLeft.count {
            linePath.move(to: pointsHorLeft[i])
            linePath.addLine(to: pointsHorRight[i])
        }

        line.path = linePath.cgPath
        line.strokeColor = UIColor(ciColor: .gray).cgColor
        line.lineWidth = 0.5
        line.lineJoin = .round
        line.fillColor = fillColor?.cgColor

        return line
    }
}

extension CGPoint {
    func add(_ space: CGPoint) -> CGPoint {
        CGPoint(x: x + space.x, y: y + space.y)
    }
}

extension CGFloat {
    func round() -> Int {
        let res = (Int(self) + 1000)/1000 * 1000
        return res
    }
}

// MARK: - AdditionalMatchInfoTableViewCell

extension PlotGpmTableViewCell: DetailedMatchInfoCellConfigurable {
    func configure(with data: MatchTableViewCellData) {
        switch data.type {
        case .plotGpmInfo(let data):
            gmpData = data
            setUpLinesAndWidthOfPlot()
            setUpLayout()
        default: assertionFailure("Произошла ошибка при заполнении ячейки данными")
        }
    }
}
