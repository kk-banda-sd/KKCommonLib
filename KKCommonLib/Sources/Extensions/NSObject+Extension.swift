import UIKit
import Haptica

public extension NSObject {
    class var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
}

public func delay(_ time: TimeInterval, callBack: @escaping() -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + time) {
        callBack()
    }
}

public func makeVibration(_ style: HapticFeedbackStyle = .light) {
    Haptic.impact(style).generate()
}

public func makeNotificationVibration(_ type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
}

public func resignAnyResponder() {
    UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
}
