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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
