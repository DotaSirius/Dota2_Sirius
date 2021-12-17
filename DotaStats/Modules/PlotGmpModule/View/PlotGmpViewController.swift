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
    
    private lazy var plot: PlotGmpView = {
//
//        let data = loadData()
//        let plotLines = data?.plotLines ?? []
//        let gridVerLines = data?.gridVerLines ?? CAShapeLayer()
//        let gridHorLines = data?.gridHorLines ?? CAShapeLayer()
//        let hieght = data?.heightOfGmpView ?? 0
//        let width = data?.widthOfGmpView ?? 0

//        let myView = PlotGmpView(plotLines: plotLines,
//                                 gridVerLines: gridVerLines,
//                                 gridHorLines: gridHorLines,
//                                 width: width,
//                                 height: hieght)
        
        let myView = PlotGmpView(plotLines: [],
                                 gridVerLines: CAShapeLayer(),
                                 gridHorLines: CAShapeLayer(),
                                 width: 0,
                                 height: 0)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.backgroundColor = .yellow
        view.backgroundColor = .systemGray2
//        print(loadData())
    }
    
    func loadData() -> (plotLines: [CAShapeLayer],
                        gridHorLines: CAShapeLayer,
                        gridVerLines: CAShapeLayer,
                        heightOfGmpView : CGFloat,
                        widthOfGmpView : CGFloat)? {
        
        guard let output = output else { return nil }

        let arrayOfGoldT = output.getArrayOfGoldT()
        let arrayOfColors = output.getArrayOfColors()
        let space = CGPoint(x: 20, y: -20)
        let widthOfMinute = (view.frame.size.width - space.x) / 16
        let heightOfGmpView : CGFloat = 300
        let widthOfGmpView = widthOfMinute * CGFloat(arrayOfGoldT[0].count)
        let fillColorOfLines = view.backgroundColor
        
        var maxGold: CGFloat = 1
        for gold in arrayOfGoldT {
            maxGold = max(maxGold, CGFloat(gold.max() ?? 1))
        }
        
        let availableHeightOfGraph = 200 + 3 * space.y
        let availableHeightOfGrid = 200 + 2 * space.y

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
                heightOfGmpView : heightOfGmpView,
                widthOfGmpView : widthOfGmpView
        )
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











































//
//let arrayOfGoldT = [[0, 255, 463, 709, 1154, 1367, 1667, 2151, 2524, 3083, 3346, 3831, 4439, 4715, 5142, 5564, 5918, 6934, 7452, 8286, 8734], [0, 293, 632, 1075, 1479, 1850, 2633, 3150, 3726, 4316, 4609, 5364, 5680, 6055, 6847, 7531, 8475, 9070, 9176, 9663, 10082],
//                    [0, 215, 474, 861, 1323, 1609, 1835, 2477, 2749, 2952, 3404, 3884, 4120, 4555, 4661, 5021, 5247, 5806, 6094, 6501, 6659],
//                    [0, 179, 279, 549, 685, 823, 996, 1183, 1289, 1395, 1501, 1606, 1857, 2017, 2123, 2518, 2936, 3280, 3386, 3712, 3873],
//                    [0, 179, 279, 379, 558, 692, 798, 1133, 1370, 1563, 1725, 1916, 2022, 2182, 2288, 2600, 2826, 3355, 3499, 3931, 4077],
//                    [0, 331, 604, 1060, 1608, 2107, 2264, 2786, 3259, 3655, 4446, 4944, 5716, 6075, 7014, 7464, 8214, 9021, 9839, 10512, 11168],
//                    [280, 459, 633, 765, 905, 1005, 1111, 1342, 1655, 1847, 2156, 2777, 2987, 3183, 3363, 3687, 3953, 4356, 4579, 5040, 5715],
//                    [17, 286, 631, 1175, 1519, 1825, 2144, 2480, 3178, 3969, 4752, 5895, 6718, 7410, 7993, 8635, 10368, 11581, 12047, 13412, 14486],
//                    [17, 196, 356, 493, 765, 865, 981, 1087, 1193, 1350, 1696, 1963, 2187, 2421, 2969, 3129, 3461, 4048, 4154, 4615, 5135],
//                    [0, 217, 425, 733, 1026, 1208, 1509, 1744, 2176, 2494, 3109, 3376, 3691, 3962, 4261, 4533, 4946, 5582, 5688, 6273, 6755]]
//let arrayOfColors: [UIColor] = [.yellow,
//                                .red,
//                                .blue,
//                                .brown,
//                                .green,
//                                .cyan,
//                                .systemPink,
//                                .systemPurple,
//                                .black,
//                                .orange]
