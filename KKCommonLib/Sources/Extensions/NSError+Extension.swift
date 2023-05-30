//
//  NSError+Extension.swift
//  KKCommonLib
//
//  Created by Kostya Karakay on 30.05.2023.
//

import Foundation

extension NSError {
    convenience init(error: String, code: Int = -777) {
        let userInfo: [String : Any] =
        [
            NSLocalizedDescriptionKey :  NSLocalizedString("Error", value: error, comment: ""),
            NSLocalizedFailureReasonErrorKey : NSLocalizedString("Error", value: error, comment: "")
        ]
        self.init(domain: Bundle.main.bundleIdentifier ?? "com.banda-sd.kkcommonlib", code: code, userInfo: userInfo)
    }
    
    var error: Error {
        return self as Error
    }
}
