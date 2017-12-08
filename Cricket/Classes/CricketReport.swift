public struct CricketReport {
    let message: String?
    let screenshotImage: UIImage?
    let viewControllerClassName: String

    public init(message: String?,
                screenshotImage: UIImage?,
                viewControllerClassName: String) {
        self.message = message
        self.screenshotImage = screenshotImage
        self.viewControllerClassName = viewControllerClassName
    }

    func detailedMessage() -> String {
        let device = UIDevice.current
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let hardwareType = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        var finalMessage = message ?? ""
        finalMessage += "\n\n--- META DATA ---\n"
        finalMessage += "\(device.name)\n"
        finalMessage += "\(hardwareType) (\(device.systemName) \(device.systemVersion))\n"
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            finalMessage += "App Version: \(version) (\(build))\n"
        }
        finalMessage += "Class: \(viewControllerClassName)\n"
        finalMessage += "\nReported using Cricket on \(Date().description(with: .current))\n"
        return finalMessage
    }
}
