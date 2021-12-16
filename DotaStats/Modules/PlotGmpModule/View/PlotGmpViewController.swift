import UIKit

// MARK: - Protocols

protocol PlotGmpModuleViewInput: AnyObject {
    func update(state: PlotGmpModuleViewState)
}

protocol PlotGmpModuleViewOutput: AnyObject {
    func getDataGoldT() -> [Int]
}

final class PlotGmpViewController: UIViewController {
    // MARK: - Properties

    private var output: PlotGmpModuleViewOutput?
    var spiner = UIActivityIndicatorView(style: .large)
    
    private lazy var scrollView : UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isScrollEnabled = true
        return view
    }()
    
    weak var plotGmpDelegate : PlotGmpDelegate?
    
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
    
    private lazy var plot : PlotGmpView = {
        let myView = PlotGmpView(goldT: [0, 180, 450, 550, 650, 750, 934, 1085, 1264, 1399, 1648, 1984, 2090, 2196, 2302, 2708, 2877, 3018, 3124, 3854, 4191, 4483, 4921, 5566, 5678, 5880, 5992, 6275, 6531, 6643, 6797, 7338, 7350],
                                 colorOfLine: .red,
                                 sizeOfScreen: view.frame.size)
        return myView
    }()
    
    
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
        
        self.scrollView.contentSize = CGSize(width: plot.bounds.width, height: plot.bounds.height)
        
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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setUpScrollView()
        setUpPlot()
        setUpLabel()
    }
}
