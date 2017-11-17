import SnapKit

protocol CricketViewControllerDelegate {
    func didSubmit(cricketViewController: CricketViewController, message: String?, screenshotImage: UIImage?)
    func didCancel(cricketViewController: CricketViewController)
}

class CricketViewController: UIViewController {
    // UI
    let screenshotImageView = CricketScreenshotImageView()
    var tintOverlayView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }()
    var infoMessageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.37, blue: 0.37, alpha: 1)
        return view
    }()
    var infoMessageLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Tap anywhere or draw a box"
        label.numberOfLines = 1
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        return label
    }()

    // Core
    let delegate: CricketViewControllerDelegate
    let screenshotImage: UIImage
    let alertController: UIAlertController

    // Constants
    let kMessageHeight: CGFloat = 64
    let kScreenshotAnimationInDuration: TimeInterval = 0.5
    let kScreenshotAnimationInDelay: TimeInterval = 0.1
    let kScreenshotAnimationOutDuration: TimeInterval = 0.5
    let kScreenshotAnimationOutDelay: TimeInterval = 0.3
    let kMessageAnimationInDuration: TimeInterval = 0.3
    let kMessageAnimationInDelay: TimeInterval = 0.4
    let kMessageAnimationOutDuration: TimeInterval = 0.3
    let kMessageAnimationOutDelay: TimeInterval = 2
    let kSpringDamping: CGFloat = 0.5
    let kSpringVelocity: CGFloat = 0.3

    // User
    var annotatedScreenshotImage: UIImage?
    var message: String?

    init(screenshotImage: UIImage, delegate: CricketViewControllerDelegate) {
        self.delegate = delegate
        self.screenshotImage = screenshotImage
        self.alertController = UIAlertController(title: "Add a message", message: nil, preferredStyle: .alert)

        super.init(nibName: nil, bundle: nil)

        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve

        alertController.addTextField { (textField) in
            textField.placeholder = "e.g. This button is too small."
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            self.dismiss(didCancel: true)
        }
        let submitAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            self.message = self.alertController.textFields?.first?.text
            self.dismiss(didCancel: false)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(submitAction)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        screenshotImageView.delegate = self
        screenshotImageView.image = screenshotImage
        screenshotImageView.isHidden = true
        infoMessageContainerView.isHidden = true

        view.addSubview(tintOverlayView)
        view.addSubview(screenshotImageView)
        view.addSubview(infoMessageContainerView)
        infoMessageContainerView.addSubview(infoMessageLabel)

        tintOverlayView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        screenshotImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        }
        infoMessageContainerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(kMessageHeight)
        }
        infoMessageLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIntro()
    }

    private func animateIntro() {
        infoMessageContainerView.transform = CGAffineTransform(translationX: 0, y: kMessageHeight)
        infoMessageContainerView.isHidden = false
        let messageInAnimationBlock = {
            self.infoMessageContainerView.transform = CGAffineTransform.identity
        }
        let messageOutAnimationBlock = {
            self.infoMessageContainerView.transform = CGAffineTransform(translationX: 0, y: self.kMessageHeight)
        }
        let completionBlock: ((Bool) -> Void) = { _ in
            UIView.animate(withDuration: self.kMessageAnimationOutDuration,
                           delay: self.kMessageAnimationOutDelay,
                           options: .curveEaseInOut,
                           animations: messageOutAnimationBlock)
        }
        UIView.animate(withDuration: kMessageAnimationInDuration,
                       delay: kMessageAnimationInDelay,
                       options: .curveEaseInOut,
                       animations: messageInAnimationBlock,
                       completion: completionBlock)

        screenshotImageView.alpha = 0
        screenshotImageView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        self.screenshotImageView.isHidden = false
        let screenshotAnimationBlock = {
            self.screenshotImageView.alpha = 1
            self.screenshotImageView.transform = CGAffineTransform.identity
        }
        UIView.animate(withDuration: kScreenshotAnimationInDuration,
                       delay: kScreenshotAnimationInDelay,
                       usingSpringWithDamping: kSpringDamping,
                       initialSpringVelocity: kSpringVelocity,
                       options: .curveEaseInOut,
                       animations: screenshotAnimationBlock,
                       completion: nil)
    }

    private func animateOutro(completion: @escaping (Bool) -> Void) {
        screenshotImageView.alpha = 1
        self.screenshotImageView.isHidden = false
        let screenshotAnimationBlock = {
            self.screenshotImageView.alpha = 0
        }
        UIView.animate(withDuration: kScreenshotAnimationOutDuration,
                       delay: kScreenshotAnimationOutDelay,
                       options: .curveEaseInOut,
                       animations: screenshotAnimationBlock,
                       completion: completion)
    }

    private func dismiss(didCancel: Bool) {
        animateOutro { (finished) in
            if didCancel {
                self.delegate.didCancel(cricketViewController: self)
            } else {
                self.delegate.didSubmit(cricketViewController: self, message: self.message, screenshotImage: self.annotatedScreenshotImage)
            }
        }
    }
}

extension CricketViewController: CricketScreenshotImageViewDelegate {
    func didFinish(cricketScreenshotImageView: CricketScreenshotImageView, screenshotImage: UIImage?) {
        annotatedScreenshotImage = screenshotImage
        present(alertController, animated: true, completion: nil)
    }
}
