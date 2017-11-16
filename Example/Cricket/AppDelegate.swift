import UIKit
import Cricket

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let viewController = MainViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
        Cricket.handler = CricketEmailHandler(emailAddress: "bugs@example.com", subjectPrefix: "[iOS]", defaultSubject: "Cricket bug report")
        return true
    }
}
