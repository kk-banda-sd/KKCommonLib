import UIKit
import SnapKit

public extension UIView {
    static func spacer(_ spacer: RigidSpacer) -> UIView { spacer }
    static func spacer(_ spacer: FlexibleSpacer) -> UIView { spacer }
}

public class RigidSpacer: UIView {
    static func square(_ side: CGFloat) -> RigidSpacer { .init(size: .init(width: side, height: side)) }
    static func wh(_ width: CGFloat, _ height: CGFloat) -> RigidSpacer { .init(size: .init(width: width, height: height)) }
    static func width(_ width: CGFloat) -> RigidSpacer { .wh(width, 0) }
    static func height(_ height: CGFloat) -> RigidSpacer { .wh(0, height) }

    init(size: CGSize) {
        super.init(frame: .zero)
        snp.makeConstraints { $0.size.equalTo(size) }
    }

    required init?(coder: NSCoder) { fatalError() }
}

public class FlexibleSpacer: UIView {
    let axis: NSLayoutConstraint.Axis

    init(axis: NSLayoutConstraint.Axis) {
        self.axis = axis
        super.init(frame: .zero)

        setContentHuggingPriority(.defaultLow, for: axis)
        setContentCompressionResistancePriority(.defaultLow, for: axis)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override var intrinsicContentSize: CGSize {
        let screenSize = UIScreen.main.bounds.size
        let width: CGFloat = axis == .horizontal ? screenSize.width : 0
        let height: CGFloat = axis == .vertical ? screenSize.height : 0

        return CGSize(width: width, height: height)
    }

    static func x() -> FlexibleSpacer { FlexibleSpacer(axis: .horizontal) }
    static func y() -> FlexibleSpacer { FlexibleSpacer(axis: .vertical) }
}
