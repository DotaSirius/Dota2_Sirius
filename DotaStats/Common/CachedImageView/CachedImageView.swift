import UIKit

class CachedImageView: UIImageView {
    private let imageLoader = ImageServiceImp()
    private let activity = UIActivityIndicatorView()



    init() {
        super.init(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        loaderLayout()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadWithUrl(_ url: String) {
        activity.startAnimating()

        imageLoader.loadWithUrl(url) { result in
            switch result {
            case .success(let newImage):
                self.image = newImage
            case .failure:
                break
            }
            self.activity.stopAnimating()
        }
    }

    private func loaderLayout() {
        backgroundColor = .white
        addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
