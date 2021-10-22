import UIKit

public extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1) {
        var alpha = alpha
        if alpha < 0 { alpha = 0 }
        if alpha > 1 { alpha = 1 }
        
        let red = (hex >> 16) & 0xff
        let green = (hex >> 8) & 0xff
        let blue = hex & 0xff
        self.init(red: red, green: green, blue: blue, transparency: alpha)!
    }
}
