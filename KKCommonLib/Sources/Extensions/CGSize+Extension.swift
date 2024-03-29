import UIKit

public extension CGSize {
    init(_ size: CGFloat) {
        self.init(width: size, height: size)
    }
    
    init(_ size: Double) {
        self.init(size.cgFloat)
    }
    
    init(_ size: Int) {
        self.init(size.cgFloat)
    }
    
    static func > (lhs: CGSize, rhs: CGSize) -> Bool {
        return lhs.width > rhs.width && lhs.height > rhs.height
    }
    
    static func < (lhs: CGSize, rhs: CGSize) -> Bool {
        return lhs.width < rhs.width && lhs.height < rhs.height
    }
}
