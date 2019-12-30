import Foundation
import SwiftyJSON

protocol JSONable {
    init?(parameter: JSON)
}

extension JSONable {
    var properties: [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
}

extension JSON {

    func toJSONString() -> String? {
        return self.rawString(options: [])
    }

    func to<T>(type: T?) -> Any? {
        if let baseObj = type as? JSONable.Type {
            guard self.type != .null, self.type != .unknown else {
                return nil
            }

            if self.type == .array {
                var arrObject: [Any] = []
                arrObject = self.arrayValue.map { baseObj.init(parameter: $0)! }
                return arrObject
            } else {
                let object = baseObj.init(parameter: self)!
                return object
            }
        }
        return nil
    }
}
