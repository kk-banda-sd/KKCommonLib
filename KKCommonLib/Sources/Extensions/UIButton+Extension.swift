import UIKit

public extension UIButton {
    private func setImageColor(_ color: UIColor) {
        guard var image = self.image(for: .normal) else { return }
        image = image.withRenderingMode(.alwaysTemplate)
        self.setImage(image, for: .normal)
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
