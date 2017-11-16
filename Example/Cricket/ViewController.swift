import UIKit
import Cricket

class ViewController: UIViewController {
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }

    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            Cricket.show()
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
