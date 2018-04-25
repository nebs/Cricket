import UIKit
import Cricket
import SnapKit

class MainViewController: ViewController {
    let imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Image1")
        view.contentMode = .scaleAspectFill
        return view
    }()
    let footerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = false
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.5
        return view
    }()
    var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.text = "Welcome to Cricket"
        label.numberOfLines = 1
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica-Bold", size: 25)
        return label
    }()
    var subtitleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.numberOfLines = 0
        label.textColor = UIColor(white: 0.4, alpha: 1)
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 16)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        let attrString = NSMutableAttributedString(string: "With Cricket your users can file bug reports and submit feedback directly from within your app! Simply shake your phone to try it out. Cricket will grab a screenshot of the screen and allow you to annotate it.")
        attrString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        label.attributedText = attrString

        return label
    }()
    var button: UIButton = {
        let button = UIButton()
        button.setTitle("Dismiss", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.93, green: 0.37, blue: 0.37, alpha: 1)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        view.addSubview(footerContainerView)
        footerContainerView.addSubview(titleLabel)
        footerContainerView.addSubview(subtitleLabel)
        footerContainerView.addSubview(button)

        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        footerContainerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(subtitleLabel.snp.top).offset(-8)
        }
        subtitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalTo(button.snp.top).offset(-16)
        }
        button.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }

    @objc func buttonPressed() {
        UIView.animate(withDuration: 0.3) { 
            self.footerContainerView.transform = CGAffineTransform(translationX: 0, y: -self.footerContainerView.bounds.height)
        }
    }
}
