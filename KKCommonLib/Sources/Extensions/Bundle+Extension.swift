import Foundation

public extension Bundle {
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
