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
    
    static var size: CGSize {
        return UIScreen.main.bounds.size
    }
    
    static var width: CGFloat {
        return self.size.width
    }
    
    static var height: CGFloat {
        return self.size.height
    }
}
