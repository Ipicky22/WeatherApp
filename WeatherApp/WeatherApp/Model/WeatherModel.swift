import Foundation

struct WeatherModel: Decodable {
    
    struct Currently: Decodable {

        var icon: String
        var temperature: Double
        var summary: String
        var windSpeed: Double
        var pressure: Double
        var humidity: Double
        var uvIndex: Int
    }
    
    struct Hourly: Decodable {
        
        var summary: String
        
        struct data: Decodable {
            var time: Int
            var icon: String
            var humidity: Double
            var temperature: Double
        }
    }
    
    struct Daily: Decodable {
        
        var summary: String
        
        struct data: Decodable {
            var time: Int
            var icon: String
            var temperatureHigh: Double
            var temperatureLow: Double
        }
    }
    
    var currently: Currently
    var hourly: Hourly
    var daily: Daily
}

