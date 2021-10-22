//
//  CGSize+Extension.swift
//  KKCommonLib
//
//  Created by Kostya Karakay on 23.10.2021.
//

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
}
