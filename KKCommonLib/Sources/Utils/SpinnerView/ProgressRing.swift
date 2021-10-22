import UIKit

class ProgressRing: UIView {
    struct Configuration {
        let lineWidth: CGFloat
        let progressColor: UIColor
        let trackColor: UIColor
    }

    var progress: CGFloat = 0.75 { didSet { didSetProgress() } }

    func setProgress(_ progress: CGFloat, animated: Bool) {
        if !animated { CALayer.performWithoutAnimation { self.progress = progress} } else { self.progress = progress }
    }

    private let trackLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()

    private let configuration: Configuration

    init(configuration: Configuration) {
        self.configuration = configuration
        super.init(frame: .zero)
        transform = .rotation(by: -.pi / 2)
        backgroundColor = .clear
        isUserInteractionEnabled = false
        layer.addSublayers(trackLayer, progressLayer)
        didSetProgress()
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        let pathRect =  bounds.inset(by: UIEdgeInsets(inset: configuration.lineWidth / 2))
        let path = UIBezierPath(arcIn: pathRect, startAngle: 0, endAngle: .pi * 2, clockwise: true)
        layoutLayer(trackLayer, path: path, strokeColor: configuration.trackColor)
        layoutLayer(progressLayer, path: path, strokeColor: configuration.progressColor)
    }

    private func didSetProgress() { progressLayer.strokeEnd = progress }

    private func layoutLayer(_ layer: CAShapeLayer, path: UIBezierPath, strokeColor: UIColor) {
        layer.path = path.cgPath
        layer.lineWidth = configuration.lineWidth
        layer.lineCap = .round
        layer.lineJoin = .round
        layer.strokeColor = strokeColor.cgColor
        layer.fillColor = .clear
        layer.frame = bounds
    }
}

extension CGColor {
    static var clear: CGColor { UIColor.clear.cgColor }
}

extension CALayer {
    func addSublayers(_ sublayers: CALayer...) { sublayers.forEach { addSublayer($0) } }

    static func performWithoutAnimation(_ actionsWithoutAnimation: () -> Void) {
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        actionsWithoutAnimation()
        CATransaction.commit()
    }
}

extension CGAffineTransform {
    static func rotation(by radians: CGFloat) -> CGAffineTransform { .init(rotationAngle: radians) }
}

extension UIBezierPath {
    convenience init(arcIn rect: CGRect, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool) {
        self.init(arcCenter: rect.center, radius: min(rect.width, rect.height) / 2, startAngle: startAngle, endAngle: endAngle,
                clockwise: clockwise)
    }
}
