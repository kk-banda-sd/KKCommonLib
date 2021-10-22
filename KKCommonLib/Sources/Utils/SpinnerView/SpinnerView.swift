import UIKit

class SpinnerView: UIView, CAAnimationDelegate {
    private lazy var ring: ProgressRing = {
        let ring = ProgressRing(configuration: .spinner())
        ring.progress = 0.25
        return ring
    }()
    init() {
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        addSubview(ring)
        ring.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) { fatalError() }

    override func didMoveToWindow() { super.didMoveToWindow(); resumeAnimatingIfNeeded() }
    override func didMoveToSuperview() { super.didMoveToSuperview(); resumeAnimatingIfNeeded() }

    var isAnimating: Bool = false { didSet { if isAnimating { startAnimating() } else { stopAnimating() } } }

    private let rotationAnimationKey = "SpinnerView.rotationAnimation"
    private func startAnimating() {
        guard ring.layer.animation(forKey: rotationAnimationKey) == nil else { return }
        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Float.pi
        rotation.duration = 0.75
        rotation.repeatCount = .infinity
        rotation.isRemovedOnCompletion = false
        rotation.isCumulative = true
        rotation.delegate = self
        ring.layer.add(rotation, forKey: rotationAnimationKey)
    }

    private func stopAnimating() { ring.layer.removeAnimation(forKey: rotationAnimationKey) }

    func animationDidStop(_: CAAnimation, finished: Bool) { startAnimating() }

    private func resumeAnimatingIfNeeded() { if isAnimating { stopAnimating(); startAnimating() } }
}

private extension ProgressRing.Configuration {
    static func spinner() -> ProgressRing.Configuration {
        .init(lineWidth: 3, progressColor: .white, trackColor: UIColor.white.withAlphaComponent(0.3))
    }
}

