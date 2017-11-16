class CricketToolbelt {
    func takeSnapshot(targetView: UIView? = UIApplication.shared.keyWindow) -> UIImage? {
        guard let targetView = targetView else {
            return nil
        }

        UIGraphicsBeginImageContextWithOptions(targetView.bounds.size, false, UIScreen.main.scale)
        targetView.drawHierarchy(in: targetView.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
