import UIKit

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

public func makeVibration(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .light) {
    let generator = UIImpactFeedbackGenerator(style: style)
    generator.impactOccurred()
}

public func makeNotificationVibration(_ type: UINotificationFeedbackGenerator.FeedbackType) {
    let generator = UINotificationFeedbackGenerator()
    generator.notificationOccurred(type)
}
