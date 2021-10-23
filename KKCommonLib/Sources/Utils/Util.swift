import UIKit

open class Util {
    private static var loaderCount: Int = 0
    
    public static var loaderView: UIView?
    public static var loaderViewSize = CGSize(52)
    
    static public func showProgress() {
        guard self.loaderCount >= 0 else { return }
        DispatchQueue.main.async {
            self.showLoader()
            self.loaderCount += 1
        }
    }
    
    static public func hideProgress() {
        guard self.loaderCount >= 1 else { return }
        DispatchQueue.main.async {
            self.hideLoader()
            if self.loaderCount > 0 {
                self.loaderCount -= 1
            }
        }
    }
    
    static public func resetProgress() {
        self.loaderCount = 0
        self.hideLoader()
    }
}

// MARK: - Private Methods
private extension Util {
    static func showLoader() {
        guard let window = UIApplication.shared.keyWindow else { return }
        for view in window.subviews {
            if view.accessibilityIdentifier == "showLoader" {
                return
            }
        }
        let v = UIView(frame: window.bounds)
        v.accessibilityIdentifier = "showLoader"
        v.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        window.addSubview(v)
        
        let loader: UIView
        if let loaderView = self.loaderView {
            loader = loaderView
        } else {
            let l = SpinnerView()
            l.isAnimating = true
            loader = l
        }
        v.addSubview(loader)
        
        loader.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(self.loaderViewSize)
        }
    }
    
    static func hideLoader() {
        guard let window = UIApplication.shared.keyWindow else { return }
        for view in window.subviews {
            guard view.accessibilityIdentifier == "showLoader" else { continue }
            view.removeFromSuperview()
        }
    }
}
