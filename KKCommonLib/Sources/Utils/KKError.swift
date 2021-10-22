import Foundation

public class KKError {
    
    // MARK: - Variables
    public var message: String = ""
    
    public var code: Int = 0
    
    // MARK: - Helpers
    public var error: Error {
        return NSError(domain: "domain", code: code, userInfo: [NSLocalizedDescriptionKey : message])
    }
}

// MARK: - Initialization
public extension KKError {
    convenience init(_ error: Error) {
        self.init()
        self.message = error.localizedDescription
        self.code = (error as NSError).code
    }
    
    convenience init(message: String, code: Int = 0) {
        self.init()
        self.message = message
        self.code = code
    }
    
    static var internalServer: KKError {
        return KKError(message: "Internal server error", code: 500)
    }
}

public extension Error {
    var kkError: KKError {
        return KKError(self)
    }
}
