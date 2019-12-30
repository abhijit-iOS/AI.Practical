import Foundation
import SwiftyJSON

struct AIResponse {
    var status      : Bool!
    var statusCode  : Int!
    var message     : String!
    var nextPage    : Int!
    var data        : Any!
    var isMoreComments : Bool!
    var isPlanActive: Int!
    
    init() {
        status     = false
        message    = ""
        statusCode = 1
        nextPage   = 1
        data       = nil
        isMoreComments = false
        isPlanActive = 0
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

        nextPage   = parameter["nextPage"].intValue
        
    }

    static var noInternetResponse: AIResponse {
        var response        = AIResponse()
        response.status     = false
        response.statusCode = 502
        response.nextPage   = -1
        response.isMoreComments = false
        response.isPlanActive = 0
        response.message    = "No Internet"
        response.data       = nil
        return response
    }
}
