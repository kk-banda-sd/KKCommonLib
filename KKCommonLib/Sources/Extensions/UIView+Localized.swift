import UIKit

public extension UIBarItem {
    @IBInspectable
    var localizedValue: String {
        get {
            return self.title ?? ""
        }
        set {
            self.title = NSLocalizedString(newValue, comment: "")
        }
    }
}

public extension UIView {
    @IBInspectable
    var localizedValue: String {
        get {
            var text: String?
            if let label = self as? UILabel {
                text = label.text
            } else if let button = self as? UIButton {
                text = button.title(for: .normal)
            } else if let textField = self as? UITextField {
                text = textField.placeholder
            }
            return text ?? ""
        }
        set {
            if let label = self as? UILabel {
                label.text = NSLocalizedString(newValue, comment: "")
            } else if let button = self as? UIButton {
                button.setTitle(NSLocalizedString(newValue, comment: ""), for: .normal)
            } else if let textField = self as? UITextField {
                textField.placeholder = NSLocalizedString(newValue, comment: "")
            }
        }
    }
}

public extension UINavigationItem {
    @IBInspectable
    var localizedValue: String {
        get {
            return self.title ?? ""
        }
        set {
            self.title = NSLocalizedString(newValue, comment: "")
        }
    }
}
