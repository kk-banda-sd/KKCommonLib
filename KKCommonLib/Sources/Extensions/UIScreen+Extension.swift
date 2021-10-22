import UIKit

public extension UIScreen {
    static func safeAreaInset() -> UIEdgeInsets {
        return UIApplication.shared.keyWindow?.safeAreaInsets ?? .zero
    }
    
    static var isDarkMode: Bool {
        if #available(iOS 13.0, *) {
            return UIScreen.main.traitCollection.userInterfaceStyle == .dark
        }
        return false
    }
}
