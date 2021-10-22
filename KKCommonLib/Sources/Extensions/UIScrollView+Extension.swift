import UIKit

public extension UIScrollView {
    func hideScrollIndicators() {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
    }
}
