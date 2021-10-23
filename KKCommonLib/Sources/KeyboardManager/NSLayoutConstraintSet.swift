import Foundation
import UIKit

public class NSLayoutConstraintSet {
    
    public var top: NSLayoutConstraint?
    public var bottom: NSLayoutConstraint?
    public var left: NSLayoutConstraint?
    public var right: NSLayoutConstraint?
    public var centerX: NSLayoutConstraint?
    public var centerY: NSLayoutConstraint?
    public var width: NSLayoutConstraint?
    public var height: NSLayoutConstraint?
    
    public init(top: NSLayoutConstraint? = nil,
                bottom: NSLayoutConstraint? = nil,
                left: NSLayoutConstraint? = nil,
                right: NSLayoutConstraint? = nil,
                centerX: NSLayoutConstraint? = nil,
                centerY: NSLayoutConstraint? = nil,
                width: NSLayoutConstraint? = nil,
                height: NSLayoutConstraint? = nil) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
        self.centerX = centerX
        self.centerY = centerY
        self.width = width
        self.height = height
    }
    
    private var availableConstraints: [NSLayoutConstraint] {
        #if swift(>=4.1)
            return [top, bottom, left, right, centerX, centerY, width, height].compactMap {$0}
        #else
            return [top, bottom, left, right, centerX, centerY, width, height].flatMap {$0}
        #endif
    }
    
    @discardableResult
    public func activate() -> Self {
        NSLayoutConstraint.activate(availableConstraints)
        return self
    }
    
    @discardableResult
    public func deactivate() -> Self {
        NSLayoutConstraint.deactivate(availableConstraints)
        return self
    }
}
