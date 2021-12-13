import UIKit

class CopyButton: UIButton {
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? ColorPalette.mainBackground : ColorPalette.alternatеBackground
        }
    }
}
