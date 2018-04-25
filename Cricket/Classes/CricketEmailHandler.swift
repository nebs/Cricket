import MessageUI

public class CricketEmailHandler: NSObject {
    let toolbelt = CricketToolbelt()
    let emailAddress: String
    let subjectPrefix: String
    let defaultSubject: String
    var baseViewController: UIViewController?

    public init(emailAddress: String, subjectPrefix: String = "", defaultSubject: String = "") {
        self.emailAddress = emailAddress
        self.subjectPrefix = subjectPrefix
        self.defaultSubject = defaultSubject
    }

    public func subject(fromReport report: CricketReport) -> String {
        let maxCharacterCount = 40
        var finalSubject = subjectPrefix
        if !finalSubject.isEmpty {
            finalSubject += " "
        }
        if let message = report.message, !message.isEmpty {
            if message.count <= maxCharacterCount {
                finalSubject += message
            } else {
                let index = message.index(message.startIndex, offsetBy: maxCharacterCount)
                finalSubject += message[..<index]

            }
        } else {
            finalSubject += defaultSubject
        }
        return finalSubject
    }
}

extension CricketEmailHandler: CricketHandler {
    public func handle(report: CricketReport) {
        guard MFMailComposeViewController.canSendMail() else {
            return
        }

        let mailComposeViewController = MFMailComposeViewController()
        mailComposeViewController.mailComposeDelegate = self
        mailComposeViewController.setToRecipients([emailAddress])
        mailComposeViewController.setSubject(subject(fromReport: report))
        mailComposeViewController.setMessageBody(report.detailedMessage(), isHTML: false)
        if let screenshotImage = report.screenshotImage, let data = UIImageJPEGRepresentation(screenshotImage, 1) {
            mailComposeViewController.addAttachmentData(data, mimeType: "image/jpeg", fileName: "screenshot.jpeg")
        }
        baseViewController = toolbelt.topViewController()
        baseViewController?.present(mailComposeViewController, animated: true, completion: nil)
    }
}

extension CricketEmailHandler: MFMailComposeViewControllerDelegate {
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        baseViewController?.dismiss(animated: true, completion: nil)
    }
}
