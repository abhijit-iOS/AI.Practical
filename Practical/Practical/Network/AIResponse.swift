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
        
        status     = parameter["status"].boolValue
        message    = parameter["message"].stringValue
        statusCode = parameter["statusCode"].intValue


        if let t = type,let key = dataKey, let d = parameter["data"][key].to(type: t)  {
            data = d
        } else if let t = type, let d = parameter["data"].to(type: t) {
            data = d
        } else {
            data = parameter
        }

        hasNextPage   = parameter["data"]["has_more"].boolValue
        
    }

    static var noInternetResponse: AIResponse {
        var response        = AIResponse()
        response.status     = false
        response.statusCode = 502
        response.hasNextPage   = false
        response.message    = "No Internet"
        response.data       = nil
        return response
    }
}
