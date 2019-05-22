import Foundation
import Alamofire

struct RequestWeather {
    static func requestCurrently(latitude: Double, longitude: Double, success: @escaping (Data)->(), failure: @escaping (Error)->()) {
        Alamofire.request("https://api.darksky.net/forecast/72827366bc934debcd54331c8e3392ca/\(latitude),\(longitude)?units=si").responseData{ (response) in
            switch response.result {
            case.success(let value):
                success(value)
            case.failure(let error):
                failure(error)
            }
        }
    }
}
