import UIKit

open class Util {
    private static var loaderCount: Int = 0
    
    static public func showProgress() {
        if self.loaderCount >= 0 {
            DispatchQueue.main.async {
                self.showLoader()
                self.loaderCount += 1
            }
        }
    }
    
    static public func hideProgress() {
        if self.loaderCount >= 1 {
            DispatchQueue.main.async {
                self.hideLoader()
                if self.loaderCount > 0 {
                    self.loaderCount -= 1
                }
            }
        }
    }
    
    static public func resetProgress() {
        self.loaderCount = 0
        self.hideLoader()
    }
    
    private static func showLoader() {
        if let window = UIApplication.shared.keyWindow {
            for view in window.subviews{
                if view.accessibilityIdentifier == "showLoader" {
                    return
                }
            }
            let v = UIView(frame: window.bounds)
            v.accessibilityIdentifier = "showLoader"
            v.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
            window.addSubview(v)
            
            let loader = SpinnerView()
            loader.isAnimating = true
            v.addSubview(loader)
            
            loader.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(52)
            }
        }
    }
    
    private static func hideLoader() {
        if let window = UIApplication.shared.keyWindow {
            for view in window.subviews{
                if view.accessibilityIdentifier == "showLoader" {
                    view.removeFromSuperview()
                }
            }
        }
    }
}
