import Foundation

public class KKError {
    
    // MARK: - Variables
    public var message: String = ""
    
    public var code: Int = 0
    
    // MARK: - Initialization
    public convenience init(_ error: Error) {
        self.init(message: error.localizedDescription, code: (error as NSError).code)
    }
    
    public convenience init(message: String, code: Int = 0) {
        self.init(message: message, code: code)
    }
    
    // MARK: - Helpers
    public var error: Error {
        return NSError(domain: "domain", code: code, userInfo: [NSLocalizedDescriptionKey : message])
    }
    
    static public var internalServer: KKError {
        return KKError(message: "Internal server error", code: 500)
    }
}

public extension Error {
    var kkError: KKError {
        return KKError(self)
    }
}
