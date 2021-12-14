import UIKit

protocol ImageNetworkService: AnyObject {
    func loadImageFromURL(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> Cancellable?
}
