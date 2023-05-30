import UIKit
import SwifterSwift

public extension String {
    var notEmpty: Bool {
        return !self.isEmpty
    }
    
    var int: Int? {
        return Int(self)
    }
    
    mutating func newLine(_ count: Int = 1) {
        for _ in 0..<count {
            self.append("\n")
        }
    }
    
    var isValidURL: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
                return match.range.length == self.utf16.count
            } else {
                return false
            }
        } catch {
            print("KKCommonLib: ERROR = \(error.localizedDescription)")
        }
        return false
    }
    
    func width(withFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.width)
    }
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func linesCount(width: CGFloat, font: UIFont) -> Int {
        guard self.count > 0 else { return 0 }
        let myText = self.nsString
        let attributes: [NSAttributedString.Key : Any] = [
            .font : font
        ]
        
        let rect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        let linesCount = round(labelSize.height / font.lineHeight).int
        return linesCount
    }
    
    var calculateTime: TimeInterval {
        guard self.notEmpty else { return 0 }
        let minTime: Double = 1500
        let maxTime: Double = 5000
        let currentTime = self.count.double * 0.06 * 1000
        var time = currentTime
        
        if time > maxTime {time = maxTime}
        if time < minTime {time = minTime}
        
        return time / 1000
    }
    
    func removeString(_ type: String) -> String {
        return self.replacingOccurrences(of: type, with: "")
    }
}
