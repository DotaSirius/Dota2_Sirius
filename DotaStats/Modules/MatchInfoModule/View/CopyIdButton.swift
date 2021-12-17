import UIKit

final class CopyIdButton: UIButton {
    override public var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? ColorPalette.mainBackground : ColorPalette.alternativeBackground
        }
    }
}
