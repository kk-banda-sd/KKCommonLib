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

// MARK: - Show/Hide
public extension UIView {
    @objc func show(_ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: KKCommonLib.animationTime, animations: {
            self.alpha = 1
        }) { (_) in
            completion?()
        }
    }
    
    var isShown: Bool {
        return alpha == 1
    }
    
    @objc func hide(_ completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: KKCommonLib.animationTime, animations: {
            self.alpha = 0
        }) { (_) in
            completion?()
        }
    }
    
    func makeBounceAnimation(_ scale: CGFloat) {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = self.transform.scaledBy(x: scale, y: scale)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1, animations: {
                self.transform = CGAffineTransform.identity
            })
        })
    }
}

// MARK: - Rotation
public extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"

    func rotate(duration: Double = 1) {
        if self.layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity

            self.layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }

    func stopRotating() {
        if self.layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            self.layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}
