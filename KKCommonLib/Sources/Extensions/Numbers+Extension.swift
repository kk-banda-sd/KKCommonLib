import UIKit

public extension Int {
    var size: CGSize {
        return CGSize(self)
    }
    
    var number: NSNumber {
        return NSNumber(integerLiteral: self)
    }
}

public extension UInt {
    var int: Int {
        return Int(self)
    }
}

public extension Double {
    var size: CGSize {
        return CGSize(self)
    }
}

public extension CGFloat {
    var size: CGSize {
        return CGSize(self)
    }
}
