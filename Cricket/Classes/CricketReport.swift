public struct CricketReport {
    let message: String?
    let screenshotImage: UIImage?

    public init(message: String?, screenshotImage: UIImage?) {
        self.message = message
        self.screenshotImage = screenshotImage
    }

    func detailedMessage() -> String {
        let device = UIDevice.current
        var finalMessage = message ?? ""
        finalMessage += "\n\n--- META DATA ---\n"
        finalMessage += "\(device.model) (\(device.name))\n"
        finalMessage += "\(device.systemName) \(device.systemVersion)\n"
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String,
            let build = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            finalMessage += "Version: \(version) (\(build))\n"
        }
        return finalMessage
    }
}
