import Foundation

struct WeatherModel: Decodable {

    // Model à partir de Currently de l'api
    struct Currently: Decodable {
        
        var icon: String
        var temperature: Double
        var summary: String
        var windSpeed: Double
        var pressure: Double
        var humidity: Double
        var uvIndex: Int
    }
    
    // Model à partir de Hourly de l'api
    struct Hourly: Decodable {
        var summary: String
        var data: [DataHourly]
    }
    
    struct DataHourly: Decodable{
        var time: Int
        var icon: String
        var humidity: Double
        var temperature: Double
    }
    
    // Model à partir de Daily de l'api
    struct Daily: Decodable {
        
        var summary: String
        var data: [DataDaily]
    }
    
    struct DataDaily: Decodable {
        var time: Int
        var icon: String
        var temperatureHigh: Double
        var temperatureLow: Double
    }
    
    var currently: Currently
    var hourly: Hourly
    var daily: Daily
}

