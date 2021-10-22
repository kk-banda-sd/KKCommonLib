import UIKit

public extension UIViewController {
    func addHideKeyboardTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    func addHideKeyboardPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        self.view.addGestureRecognizer(panGesture)
    }
    
    func addHideKeyboardGestures() {
        self.addHideKeyboardTapGesture()
        self.addHideKeyboardPanGesture()
    }
    
    @objc func hideKeyboard() {
        self.view.endEditing(true)
    }
}
