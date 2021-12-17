import UIKit

// MARK: - Protocols

protocol PlotGmpModuleViewInput: AnyObject {
    func update(state: PlotGmpModuleViewState)
}

protocol PlotGmpModuleViewOutput: AnyObject {
    func getArrayOfGoldT() -> [[Int]]
    func getArrayOfColors() -> [UIColor]
    func getArrayOfHeroes() -> [String]
    func getScaledGoldT(arrays: [[Int]],
                        widthOfMinute: CGFloat,
                        height: CGFloat,
                        heightOfGmpView: CGFloat,
                        maxGold: CGFloat,
                        space: CGPoint) -> [[CGPoint]]
    func getPointsInGoldAxis(maxGold: CGFloat) -> [Int]
    func getScaledHorLeft(pointsInGoldAxis points: [Int],
                          height: CGFloat,
                          heightOfGmpView: CGFloat,
                          maxGold: CGFloat,
                          space: CGPoint) -> [CGPoint]
    func getScaledHorRight(pointsInGoldAxis points: [Int],
                           height: CGFloat,
                           heightOfGmpView: CGFloat,
                           maxGold: CGFloat,
                           goldTCount: Int,
                           space: CGPoint,
                           widthOfMinute: CGFloat) -> [CGPoint]
    func getScaledVerBottom(goldTCount: Int,
                            widthOfMinute: CGFloat,
                            heightOfGmpView: CGFloat,
                            space: CGPoint) -> [CGPoint]
    func getScaledVerTop(goldTCount: Int,
                         height: CGFloat,
                         heightOfGmpView: CGFloat,
                         space: CGPoint,
                         maxGold: CGFloat,
                         widthOfMinute: CGFloat,
                         pointsInGoldAxis points: [Int]) -> [CGPoint]
    func getPlotLines(form arrays: [[CGPoint]],
                      colors: [UIColor],
                      fillColor: UIColor?) -> [CAShapeLayer]
    func getVertGridLines(pointsVertBottom: [CGPoint],
                          pointsVertTop: [CGPoint],
                          fillColor: UIColor?) -> CAShapeLayer
    func getHorGridLines(pointsHorLeft: [CGPoint],
                         pointsHorRight: [CGPoint],
                         fillColor: UIColor?) -> CAShapeLayer
}

final class PlotGmpViewController: UIViewController {
    // MARK: - Properties

    private var output: PlotGmpModuleViewOutput?
    var spiner = UIActivityIndicatorView(style: .large)

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        return view
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = ColorPalette.alternativeBackground
        label.text = "GMP"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = ColorPalette.mainText
        return label
    }()
    
    private lazy var vertStackView: UIStackView = {
        let stackView = UIStackView()
        
        return stackView
    }()

    private lazy var plot: PlotGmpView = {

        let data = loadData()
        let plotLines = data?.plotLines ?? []
        let gridVerLines = data?.gridVerLines ?? CAShapeLayer()
        let gridHorLines = data?.gridHorLines ?? CAShapeLayer()
        let hieght = data?.heightOfGmpView ?? 0
        let width = data?.widthOfGmpView ?? 0

        let myView = PlotGmpView(plotLines: plotLines,
                                 gridVerLines: gridVerLines,
                                 gridHorLines: gridHorLines,
                                 width: width,
                                 height: hieght)

        return myView
    }()

    // MARK: - Init

    init(output: PlotGmpModuleViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Set up UILabel "GMP"

    private func setUpLabel() {
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            label.bottomAnchor.constraint(equalTo: scrollView.topAnchor)
        ])
    }

    // MARK: - Set up UIPlotGmpView

    private func setUpPlot() {
        scrollView.addSubview(plot)
    }

    // MARK: - Set up UIScrollView

    private func setUpScrollView() {
        view.addSubview(scrollView)

        scrollView.contentSize = CGSize(width: plot.bounds.width, height: plot.bounds.height)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            scrollView.bottomAnchor.constraint(equalTo: scrollView.topAnchor, constant: 220)
        ])
    }
    
    // MARK: - Set up UIStackView

    private func setUpStackView() {
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.backgroundColor = .yellow
        view.backgroundColor = .systemGray2
    }

    // swiftlint:disable large_tuple
    func loadData() -> (plotLines: [CAShapeLayer],
                        gridHorLines: CAShapeLayer,
                        gridVerLines: CAShapeLayer,
                        heightOfGmpView: CGFloat,
                        widthOfGmpView: CGFloat)? {
    // swiftlint:enable large_tuple
        guard let output = output else { return nil }

        let arrayOfGoldT = output.getArrayOfGoldT()
        let arrayOfColors = output.getArrayOfColors()
        let space = CGPoint(x: 20, y: -20)
        let widthOfMinute = (view.frame.size.width - space.x) / 16
        let heightOfGmpView: CGFloat = 220
        let widthOfGmpView = widthOfMinute * CGFloat(arrayOfGoldT[0].count) + space.x
        let fillColorOfLines = UIColor.white

        var maxGold: CGFloat = 1
        for gold in arrayOfGoldT {
            maxGold = max(maxGold, CGFloat(gold.max() ?? 1))
        }

        let availableHeightOfGraph = 220 + 3 * space.y
        let availableHeightOfGrid = 220 + 2 * space.y

        let scaledGoldPoints = output.getScaledGoldT(arrays: arrayOfGoldT,
                                                     widthOfMinute: widthOfMinute,
                                                     height: availableHeightOfGraph,
                                                     heightOfGmpView: heightOfGmpView,
                                                     maxGold: maxGold,
                                                     space: space)

        let marksInGoldAxis = output.getPointsInGoldAxis(maxGold: maxGold)

        let pointsHorLeftGrid = output.getScaledHorLeft(pointsInGoldAxis: marksInGoldAxis,
                                                        height: availableHeightOfGrid,
                                                        heightOfGmpView: heightOfGmpView,
                                                        maxGold: maxGold,
                                                        space: space)

        let pointsHorRightGrid = output.getScaledHorRight(pointsInGoldAxis: marksInGoldAxis,
                                                          height: availableHeightOfGrid,
                                                          heightOfGmpView: heightOfGmpView,
                                                          maxGold: maxGold,
                                                          goldTCount: arrayOfGoldT[0].count,
                                                          space: space,
                                                          widthOfMinute: widthOfMinute)

        let pointdVerBottomGrid = output.getScaledVerBottom(goldTCount: arrayOfGoldT[0].count,
                                                            widthOfMinute: widthOfMinute,
                                                            heightOfGmpView: heightOfGmpView,
                                                            space: space)

        let pointdVerTopGrid = output.getScaledVerTop(goldTCount: arrayOfGoldT[0].count,
                                                      height: availableHeightOfGrid,
                                                      heightOfGmpView: heightOfGmpView,
                                                      space: space,
                                                      maxGold: maxGold,
                                                      widthOfMinute: widthOfMinute,
                                                      pointsInGoldAxis: marksInGoldAxis)

        // MARK: - Get lines from [CGPoints]

        let gridHorLines = output.getHorGridLines(pointsHorLeft: pointsHorLeftGrid,
                                                  pointsHorRight: pointsHorRightGrid,
                                                  fillColor: fillColorOfLines)

        let gridVerLines = output.getVertGridLines(pointsVertBottom: pointdVerBottomGrid,
                                                   pointsVertTop: pointdVerTopGrid,
                                                   fillColor: fillColorOfLines)

        let plotLines = output.getPlotLines(form: scaledGoldPoints,
                                            colors: arrayOfColors,
                                            fillColor: fillColorOfLines)

        return (plotLines: plotLines,
                gridHorLines: gridHorLines,
                gridVerLines: gridVerLines,
                heightOfGmpView: heightOfGmpView,
                widthOfGmpView: widthOfGmpView)
    }
}

// MARK: - PlotGmpModuleViewInput

extension PlotGmpViewController: PlotGmpModuleViewInput {
    func update(state: PlotGmpModuleViewState) {
        switch state {
        case .loading:
            spiner.color = ColorPalette.accent
            view.addSubview(spiner)
            spiner.center = view.center
            spiner.startAnimating()
        case .error:
            spiner.removeFromSuperview()
        case .success:
            spiner.removeFromSuperview()
            setUpScrollView()
            setUpPlot()
            setUpLabel()
        }
    }
}
