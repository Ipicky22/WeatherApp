//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Efreitech on 22/05/2019.
//  Copyright © 2019 Adrien & Maxime. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {

    // Model from Currently => API
    struct Currently: Decodable {
        
        var icon: String
        var temperature: Double
        var summary: String
        var windSpeed: Double
        var pressure: Double
        var humidity: Double
        var uvIndex: Int
    }
    
    // Model from Hourly => API
    struct Hourly: Decodable {
        var summary: String
        var data: [DataHourly]
    }
    
    struct DataHourly: Decodable {
        var time: Double
        var icon: String
        var humidity: Double
        var temperature: Double
    }
    
    // Model from Daily => API
    struct Daily: Decodable {
        
        var summary: String
        var data: [DataDaily]
    }
    
    struct DataDaily: Decodable {
        var time: Double
        var icon: String
        var temperatureHigh: Double
        var temperatureLow: Double
    }
    
    var currently: Currently
    var hourly: Hourly
    var daily: Daily
    var timezone: String
}

