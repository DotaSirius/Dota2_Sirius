import UIKit

final class PlotGmpView: UIView {
    private var plotLines: [CAShapeLayer]
    private var gridVerLines: CAShapeLayer
    private var gridHorLines: CAShapeLayer

    init(plotLines: [CAShapeLayer],
         gridVerLines: CAShapeLayer,
         gridHorLines: CAShapeLayer,
         width: CGFloat,
         height: CGFloat) {
        self.plotLines = plotLines
        self.gridHorLines = gridHorLines
        self.gridVerLines = gridVerLines

        super.init(frame: CGRect(origin: .zero,
                                 size: CGSize(width: width,
                                              height: height)))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        layer.backgroundColor = UIColor(ciColor: .white).cgColor
        for line in plotLines {
            layer.addSublayer(line)
        }
        layer.addSublayer(gridVerLines)
        layer.addSublayer(gridHorLines)
    }
}
