public protocol CricketHandler {
    func handle(report: CricketReport)
}

public class Cricket {
    public var handler: CricketHandler?
    var isShowing = false
    var baseViewController: UIViewController?
    private let toolbelt = CricketToolbelt()

    public init() {

    }

    public func show() {
        guard handler != nil else {
            return
        }

        if isShowing {
            baseViewController?.dismiss(animated: true, completion: { 
                self.isShowing = false
            })
        } else {
            guard let screenshotImage = toolbelt.takeSnapshot(), let viewController = toolbelt.topViewController() else {
                return
            }

            isShowing = true
            let cricketViewController = CricketViewController(screenshotImage: screenshotImage, delegate: self)
            viewController.present(cricketViewController, animated: true, completion: nil)
            baseViewController = viewController
        }
    }
}

// Shared instance
extension Cricket {
    public static let sharedInstance = Cricket()
    public static var handler: CricketHandler? {
        set {
            sharedInstance.handler = newValue
        }
        get {
            return sharedInstance.handler
        }
    }
    public static func show() {
        sharedInstance.show()
    }
}

extension Cricket: CricketViewControllerDelegate {
    func didSubmit(cricketViewController: CricketViewController, message: String?, screenshotImage: UIImage?) {
        baseViewController?.dismiss(animated: true, completion: {
            self.isShowing = false
            let report = CricketReport(message: message, screenshotImage: screenshotImage)
            self.handler?.handle(report: report)
        })
    }

    func didCancel(cricketViewController: CricketViewController) {
        baseViewController?.dismiss(animated: true, completion: { 
            self.isShowing = false
        })
    }
}
