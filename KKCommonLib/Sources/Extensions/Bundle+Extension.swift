//
//  Bundle+Extension.swift
//  KKCommonLib
//
//  Created by Kostya Karakay on 23.10.2021.
//

import Foundation

extension Bundle {
    var releaseVersionNumber: String {
        return self.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    var buildVersionNumber: String {
        return self.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
    
    var appVersion: String {
        return self.releaseVersionNumber + "." + self.buildVersionNumber
    }
}
