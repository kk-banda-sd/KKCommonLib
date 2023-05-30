import UIKit

// MARK: - Keyboard
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

// MARK: - Navigation
public extension UIViewController {
    func push(_ vc: UIViewController, animated: Bool = true) {
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    
    func set(_ vc: UIViewController, animated: Bool = true) {
        self.navigationController?.setViewControllers([vc], animated: animated)
    }
    
    func pop(_ animated: Bool = true) {
        self.navigationController?.popViewController(animated: animated)
    }
    
    func popToRoot(_ animated: Bool = true) {
        self.navigationController?.popToRootViewController(animated: animated)
    }
    
    func popToVC(_ vcType: UIViewController.Type, animated: Bool = true) {
        guard let nvc = self.navigationController, let vc = self.getVC(vcType) else { return }
        nvc.popToViewController(vc, animated: animated)
    }
    
    func getVC(_ vcType: UIViewController.Type) -> UIViewController? {
        return self.navigationController?.viewControllers.first(where: { type(of: $0) == vcType })
    }
}
