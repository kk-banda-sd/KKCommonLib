import UIKit

public extension UserDefaults {
    func hasValue(forKey key: String) -> Bool {
        return self.value(forKey: key) != nil
    }
}
