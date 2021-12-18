import UIKit

final class SquareLoadingView: UIView {
    private enum Constant {
        static let scaleTo: CGFloat = 0.01
        static let side: CGFloat = 50
        static let duration: TimeInterval = 1.0
        static let fadeOutDuration: TimeInterval = 0.4
        static let fadeInDuration: TimeInterval = 0.4
    }

    private enum HorizontalPosition {
        case left, middle, right
    }

    private enum VerticalPosition {
        case top, center, bottom
    }

    private lazy var leftTopView = makeView(.left, .top)
    private lazy var leftCenterView = makeView(.left, .center)
    private lazy var leftBottomView = makeView(.left, .bottom)
    private lazy var middleTopView = makeView(.middle, .top)
    private lazy var middleCenterView = makeView(.middle, .center)
    private lazy var middleBottomView = makeView(.middle, .bottom)
    private lazy var rightTopView = makeView(.right, .top)
    private lazy var rightCenterView = makeView(.right, .center)
    private lazy var rightBottomView = makeView(.right, .bottom)
    
    private var isAnimating: Bool = false

    var squareColor = ColorPalette.accent
    var duration: TimeInterval = Constant.duration

    convenience init() {
        self.init(side: Constant.side)
    }

    init(side: CGFloat) {
        let frame = CGRect(origin: .zero, size: CGSize(width: side, height: side))
        super.init(frame: frame)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if isAnimating {
            startAnimation()
        }
    }

    func startAnimation() {
        isAnimating = true
        
        guard window != nil else {
            return
        }
        
        fadeIn()

        let array = [
            [leftTopView],
            [leftCenterView, middleTopView],
            [leftBottomView, middleCenterView, rightTopView],
            [middleBottomView, rightCenterView],
            [rightBottomView]
        ]

        for (index, viewArray) in array.enumerated() {
            viewArray.forEach { view in
                UIView.animate(withDuration: duration, delay: 0.1 * Double(index), options: [.autoreverse, .repeat], animations: {
                    view.transform = CGAffineTransform(scaleX: Constant.scaleTo, y: Constant.scaleTo)
                }, completion: { _ in
                    view.transform = .identity
                })
            }
        }
    }

    func stopAnimation() {
        isAnimating = false
        fadeOut()
    }

    private func fadeOut() {
        UIView.animate(withDuration: Constant.fadeOutDuration) {
            self.alpha = 0
        } completion: { _ in
            self.removeFromSuperview()
        }
    }

    private func fadeIn() {
        UIView.animate(withDuration: Constant.fadeInDuration) {
            self.alpha = 1
        }
    }

    private func setup() {
        addSubview(leftTopView)
        addSubview(leftCenterView)
        addSubview(leftBottomView)
        addSubview(middleTopView)
        addSubview(middleBottomView)
        addSubview(rightTopView)
        addSubview(rightCenterView)
        addSubview(rightBottomView)
        addSubview(middleCenterView)
    }

    private func makeView(_ xPos: HorizontalPosition, _ yPos: VerticalPosition) -> UIView {
        let side = frame.width / 3
        var x: CGFloat
        switch xPos {
        case .left:
            x = frame.width / 6
        case .middle:
            x = frame.width / 2
        case .right:
            x = 5 * (frame.width / 6)
        }

        var y: CGFloat
        switch yPos {
        case .top:
            y = frame.height / 6
        case .center:
            y = frame.height / 2
        case .bottom:
            y = 5 * (frame.height / 6)
        }

        let view = UIView(frame: CGRect(x: x, y: y, width: side, height: side))
        view.backgroundColor = squareColor
        return view
    }
}
