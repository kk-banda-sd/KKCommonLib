//
//  NSMutableAttributedString+Extension.swift
//  KKCommonLib
//
//  Created by Kostya Karakay on 30.05.2023.
//

import UIKit
import Foundation

extension NSAttributedString {
    func lineCount(atSize size: CGSize) -> Int {
        let attrs = self.attributes(at: 0, effectiveRange: nil)
        guard let font = (attrs[.font] as? UIFont) else { return 0 }
        let paragraph = attrs[.paragraphStyle] as? NSParagraphStyle
        let fontMultiplyer = paragraph?.lineHeightMultiple ?? 1.0
        let lineSpacing = paragraph?.lineSpacing ?? 0
        
        let singleLineHeight: CGFloat
        if fontMultiplyer != 0 {
            singleLineHeight = ceil(font.lineHeight * fontMultiplyer + lineSpacing)
        } else {
            singleLineHeight = ceil(font.lineHeight + lineSpacing)
        }
        
        let textHeight = self.boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil).height
        return Int(ceil(textHeight / singleLineHeight))
    }
    
    func linesCount(_ width: CGFloat) -> Int {
        guard self.string.count > 0 else { return 0 }
        let attributes = self.attributes(at: 0, effectiveRange: nil)
        let myText = self.string as NSString
        let myAttributes = attributes
        
        let rect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = myText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: myAttributes, context: nil)
        
        if let style = attributes[.paragraphStyle] as? NSParagraphStyle, style.minimumLineHeight != 0 {
            let linesCount = Int(ceil(CGFloat(labelSize.height) / style.minimumLineHeight))
            return linesCount
        } else {
            let font = attributes[NSAttributedString.Key.font] as! UIFont
            let linesCount = round(labelSize.height / font.lineHeight).int
            return linesCount
        }
    }
}

extension NSMutableAttributedString {
    func space() {
        self.append(NSAttributedString(string: " "))
    }
    
    func newLine() {
        self.append(NSAttributedString(string: "\n"))
    }
}
