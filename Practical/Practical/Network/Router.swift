import Alamofire
import Foundation
import SwiftyJSON

protocol Routable {
    var path        : String { get }
    var method      : HTTPMethod { get }
    var parameters  : Parameters? { get }
    var dataKey     : String? { get }
    var type        : JSONable.Type? { get }
}

enum Router: Routable, Equatable {
    case getUserList

    static func ==(lhs: Router, rhs: Router) -> Bool {
        return lhs.path == rhs.path
    }
}

extension Router {
    var path: String {
        var endPoint = ""
        switch self {
        case .getUserList:
            endPoint = "http://sd2-hiring.herokuapp.com/api/users?"
        }
        return endPoint
    }
}

extension Router {
    var method: HTTPMethod {
        switch self {
        case .getUserList:
            return .get
        }
    }
}

extension Router {
    var parameters: Parameters? {
        switch self {
        case .getUserList:
            return nil
        }
    }
}

extension Router {
    var dataKey: String? {
        switch self {
        case .getUserList:
            return "users"
        }
    }
}

extension Router {
    var type: JSONable.Type? {
        switch self {
        case .getUserList:
            return User.self
        }
    }
}


