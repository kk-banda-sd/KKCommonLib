import UIKit

public extension UIDevice {
    func setPortrait() {
        setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    func setLandscapeRight() {
        setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
    }
    
    func setLandscapeLeft() {
        setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
    }
}
