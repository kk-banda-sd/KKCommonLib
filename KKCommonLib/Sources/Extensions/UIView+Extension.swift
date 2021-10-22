import UIKit

public extension UIView {
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: self.className, bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            return view
        }
        return UIView()
    }
}

// MARK: - Shadow
public extension UIView {
    func setupShadow(_ cornerRadius: CGFloat? = nil, color: UIColor = UIColor(red: 0.00, green: 0.00, blue: 0.00, alpha: 0.5)) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = .zero
        if let cornerRadius = cornerRadius {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    func setupShadowForNavigationBar(radius: CGFloat = 6, opacity: Float = 0.05, color: UIColor = .black, offset: CGSize = CGSize(width: 0, height: 6)) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
    }
}
