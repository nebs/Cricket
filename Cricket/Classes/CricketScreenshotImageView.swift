import SnapKit

protocol CricketScreenshotImageViewDelegate: class {
    func didFinish(cricketScreenshotImageView: CricketScreenshotImageView, screenshotImage: UIImage?)
}

class CricketScreenshotImageView: UIImageView {
    weak var delegate: CricketScreenshotImageViewDelegate?
    private let toolbelt = CricketToolbelt()

    var annotationViewPointA = CGPoint.zero
    var annotationViewPointB = CGPoint.zero

    var annotationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.layer.borderColor = UIColor.green.cgColor
        view.layer.borderWidth = 3
        return view
    }()

    public init() {
        super.init(image: nil)
        addSubview(annotationView)
        annotationView.isHidden = true
        isUserInteractionEnabled = true
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        contentMode = .scaleAspectFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if let touch = event?.allTouches?.first {
            let touchPoint = touch.location(in: self)
            annotationViewPointA = touchPoint
            annotationViewPointB = touchPoint
            updateAnnotationView()
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        if let touch = event?.allTouches?.first {
            let touchPoint = touch.location(in: self)
            annotationViewPointB = touchPoint
            updateAnnotationView()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        delegate?.didFinish(cricketScreenshotImageView: self, screenshotImage: toolbelt.takeSnapshot(targetView: self))
    }

    private func updateAnnotationView() {
        let x = annotationViewPointA.x
        let y = annotationViewPointA.y
        let w = annotationViewPointB.x - x
        let h = annotationViewPointB.y - y
        annotationView.frame = CGRect(x: x, y: y, width: w, height: h)
        annotationView.isHidden = w == 0 || h == 0
    }
}
