import UIKit

 class CopyIdButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? ColorPalette.mainBackground : ColorPalette.alternativeBackground
        }
    }
}
