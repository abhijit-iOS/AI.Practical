import Foundation
import SwiftyJSON

struct AIResponse {
    var status      : Bool!
    var statusCode  : Int!
    var message     : String!
    var hasNextPage : Bool!
    var data        : Any!
    
    
    init() {
        status      = false
        message     = ""
        statusCode  = 1
        hasNextPage = false
        data        = nil
        
    }

    init<T>(parameter: JSON, dataKey: String?, type: T? = nil) {
        
        status     = parameter[Key.status].boolValue
        message    = parameter[Key.message].stringValue
        statusCode = parameter[Key.statusCode].intValue


        if let t = type,let key = dataKey, let d = parameter[Key.data][key].to(type: t)  {
            data = d
        } else if let t = type, let d = parameter[Key.data].to(type: t) {
            data = d
        } else {
            data = parameter
        }

        hasNextPage   = parameter[Key.data][Key.has_more].boolValue
        
    }

    static var noInternetResponse: AIResponse {
        var response        = AIResponse()
        response.status     = false
        response.statusCode = 502
        response.hasNextPage   = false
        response.message    = Message.noInternet
        response.data       = nil
        return response
    }
}
