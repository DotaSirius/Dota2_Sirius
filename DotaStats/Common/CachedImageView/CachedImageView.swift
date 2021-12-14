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
    private var isAnimateRunning = false

    private let lastRequest: Cancellable? = nil

    init() {
        super.init(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadWithUrl(_ url: String) {
        startAnimation()

        if let lastRequest = lastRequest {
            lastRequest.cancel()
        }

        imageLoader.loadWithUrl(url) { [weak self] result in
            switch result {
            case .success(let newImage):
                self?.image = newImage
            case .failure:
                guard let errorImage = UIImage(named: "error_load_image") else {
                    return
                }
                self?.image = errorImage
                break
            }
            self?.stopAnimation()
        }
    }

    private func setupImageView() {
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }

    private func startAnimation() {
        guard !isAnimateRunning else {
            return
        }
        isAnimateRunning = true

        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)

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
        isAnimateRunning = false
        gradientLayer.removeFromSuperlayer()
        gradientLayer.removeAllAnimations()
    }
}
