//

import UIKit

protocol AlertViewController {
}

extension AlertViewController where Self: UIViewController {

    func showAlertView(title: String?, message: String?, cancelButton: String?, otherButtons: [String]? = nil,
                       type: UIAlertControllerStyle = .alert, cancelAction: (() -> Void)? = nil,
                       otherAction: ((Int) -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)

        if let cancelButton = cancelButton {
            let cancelAction = UIAlertAction(title: cancelButton, style: .cancel, handler: { (_) in
                cancelAction?()
            })
            alertViewController.addAction(cancelAction)
        }

        if let otherButtons = otherButtons {
            for (index, otherButton) in otherButtons.enumerated() {
                let otherAction = UIAlertAction(title: otherButton,
                                                style: .default, handler: { (_) in
                                                    otherAction?(index)
                })
                alertViewController.addAction(otherAction)
            }
        }
        DispatchQueue.main.async {
            self.present(alertViewController, animated: true, completion: nil)
        }
    }

    func showErrorAlert(message: String?) {
        showAlertView(title: "Error", message: message, cancelButton: "OK")
    }
}
