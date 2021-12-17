import UIKit

final class CachedImageView: UIImageView {
    private let imageLoader = ImageServiceImp.shared

    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = [UIColor.lightGray.cgColor,
                                UIColor.white.cgColor,
                                UIColor.lightGray.cgColor]

        return gradientLayer
    }()

    private var isAnimationRunning = false

    private var lastRequest: Cancellable?

    var errorPlaceholder: UIImage?

    init() {
        super.init(frame: .zero)
        layer.addSublayer(gradientLayer)
        gradientLayer.isHidden = true
        setupImageView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        gradientLayer.frame = frame
    }


    func setImage(with url: String) {
        startAnimation()

        if let lastRequest = lastRequest {
            lastRequest.cancel()
        }

        imageLoader.fetchImage(with: url) { [weak self] result in
            switch result {
            case .success(let newImage):
                self?.image = newImage
            case .failure:
                if let errorPlaceholder = self?.errorPlaceholder {
                    self?.image = errorPlaceholder
                } else if let errorImage = UIImage(named: "error_load_image") {
                    self?.image = errorImage
                }
            }
            self?.stopAnimation()
        }
    }

    private func setupImageView() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }

    private func startAnimation() {
        guard !isAnimationRunning else {
            return
        }
        isAnimationRunning = true
        gradientLayer.isHidden = false

        let startLocations: [NSNumber] = [-1, -0.5, 0]
        let endLocations: [NSNumber] = [1, 1.5, 2]
        gradientLayer.locations = startLocations

        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = startLocations
        animation.toValue = endLocations
        animation.duration = 1
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)

        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 2
        animationGroup.animations = [animation]
        animationGroup.repeatCount = .infinity
        gradientLayer.add(animationGroup, forKey: animation.keyPath)
    }

    private func stopAnimation() {
        isAnimationRunning = false
        gradientLayer.isHidden = true
        gradientLayer.removeAllAnimations()
    }
}
