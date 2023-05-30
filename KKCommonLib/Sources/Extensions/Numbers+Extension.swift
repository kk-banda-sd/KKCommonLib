import UIKit

public extension Int {
    var uInt: UInt {
        return UInt(self)
    }
    
    var string: String {
        return String(self)
    }
    
    var double: Double {
        return Double(self)
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    var float: Float {
        return Float(self)
    }
    
    var number: NSNumber {
        return NSNumber(integerLiteral: self)
    }
    
    var size: CGSize {
        return CGSize(self)
    }
    
    var decomalFormat: String {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        
        return formatter.string(from: self.number) ?? self.string
    }
    
    func toFileSize(in units: ByteCountFormatter.Units = [.useAll]) -> String {
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = units
        bcf.countStyle = .file
        let string = bcf.string(fromByteCount: Int64(self))
        return string
    }
}

public extension UInt {
    var int: Int {
        return Int(self)
    }
}

public extension Double {
    var string: String {
        return String(self)
    }
    
    var int: Int {
        guard !self.isNaN && !self.isInfinite else { return 0 }
        return Int(self)
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    var float: Float {
        return Float(self)
    }
    
    var size: CGSize {
        return CGSize(self)
    }
}

public extension CGFloat {
    var int: Int {
        return Int(self)
    }
    
    var cgFloat: Float {
        return Float(self)
    }
    
    var double: Double {
        return Double(self)
    }
    
    var size: CGSize {
        return CGSize(self)
    }
}

public extension Float {
    var string: String {
        return String(self)
    }
    
    var int: Int {
        return Int(self)
    }
    
    var cgFloat: CGFloat {
        return CGFloat(self)
    }
    
    var double: Double {
        return Double(self)
    }
}
