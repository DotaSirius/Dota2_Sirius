import UIKit

final class PlotGpmTableViewCell: UITableViewCell {
    static let reuseIdentifier = "PlotGpmTableViewCell"
    
    private let scrollView = UIScrollView()
    private let heightOfGmpView : CGFloat = 300
    private var widthOfGmpView : CGFloat = 0

    private var plotLines: [CAShapeLayer] = []
    private var gridVerLines = CAShapeLayer()
    private var gridHorLines = CAShapeLayer()
    private var gmpData: [PlotGpmInfo] = []

    private lazy var plot : UIView = {
        return makePlotView()
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
        contentView.addSubview(scrollView)
        scrollView.addSubview(plot)
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize = CGSize(width: widthOfGmpView, height: heightOfGmpView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: contentView.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: heightOfGmpView)
        ])
        
    }

    private func makePlotView() -> UIView {
        let plotView = UIView(frame: CGRect(x: 0, y: 0,
                                            width: widthOfGmpView, height: heightOfGmpView))
        for line in plotLines {
            plotView.layer.addSublayer(line)
        }
        layer.addSublayer(gridVerLines)
        layer.addSublayer(gridHorLines)
        return plotView
    }

    private func setUpLinesAndWidthOfPlot() {
        let space = CGPoint(x: 20, y: -20) // indent left bottom
        let widthOfMinute = (contentView.frame.size.width - space.x)/16
        let minutesCount = gmpData[0].gmp.count
        let fillColorOfLines = contentView.backgroundColor

        widthOfGmpView = widthOfMinute * CGFloat(minutesCount)

        var maxGold: CGFloat = 1
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

        let marksInGoldAxis = getPointsInGoldAxis(maxGold: maxGold)

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

    private func getScaledGoldT(gmpData: [PlotGpmInfo],
                                widthOfMinute: CGFloat,
                                height: CGFloat,
                                heightOfGmpView: CGFloat,
                                maxGold: CGFloat,
                                space: CGPoint) -> [[CGPoint]] {
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
                                  space: CGPoint) -> [CGPoint] {
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
                                   widthOfMinute: CGFloat) -> [CGPoint] {
        let multY = height/maxGold
        let x = CGFloat(minutesCount) * widthOfMinute // TODO: check -1
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
                                    space: CGPoint) -> [CGPoint] {
        let y: CGFloat = heightOfGmpView
        var res = [CGPoint]()
        for i in 0..<minutesCount where i % 2 == 0 {
            let scaledPoint = CGPoint(x: widthOfMinute * CGFloat(i),
                                      y: y)
            res.append(scaledPoint.add(space))
        }

        return res
    }

    private func getScaledVerTop(minutesCount: Int,
                                 height: CGFloat,
                                 heightOfGmpView: CGFloat,
                                 space: CGPoint,
                                 maxGold: CGFloat,
                                 widthOfMinute: CGFloat,
                                 pointsInGoldAxis points: [Int]) -> [CGPoint] {
        let multY = height/maxGold
        let y: CGFloat = heightOfGmpView - CGFloat(points.last ?? 0) * multY

        var res = [CGPoint]()
        for i in 0..<minutesCount where i % 2 == 0 {
            let scaledPoint = CGPoint(x: widthOfMinute * CGFloat(i),
                                      y: y)
            res.append(scaledPoint.add(space))
        }

        return res
    }

    private func getPlotLines(form arrays: [[CGPoint]],
                              gmpData: [PlotGpmInfo],
                              fillColor: UIColor?) -> [CAShapeLayer] {
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
                                  fillColor: UIColor?) -> CAShapeLayer {
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
                                 fillColor: UIColor?) -> CAShapeLayer {
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
