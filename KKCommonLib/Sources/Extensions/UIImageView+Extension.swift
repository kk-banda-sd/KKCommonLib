import UIKit

public extension UIImageView {
    private func setImageColor(_ color: UIColor) {
        guard var image = self.image else { return }
        image = image.withRenderingMode(.alwaysTemplate)
        self.image = image
        self.tintColor = color
    }
    
    @IBInspectable
    var imageTintColor: UIColor {
        get {
            return self.tintColor
        }
        set {
            self.setImageColor(newValue)
        }
    }
}
