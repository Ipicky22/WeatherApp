//
//  HourlyTableViewCell.swift
//  WeatherApp
//
//  Created by Adrien & Maxime Masson on 22/05/2019.
//  Copyright © 2019 Adrien & Maxime. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    func configure(time: Double, temperature: Double, humidity: Double, iconHourly: String, timezone: String) {
        
        // CONVERSION
        // Returns a date object initialized relative to 00:00:00 UTC on 1 January 1970 by a given number of seconds
        let date = NSDate(timeIntervalSince1970: time)
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("HH")
        formatter.timeZone = TimeZone(identifier: timezone)          // local time (city)
        
        // VALUES
        timeLabel.text = "\(formatter.string(from: date as Date))"
        temperatureLabel.text = String("\(Int(temperature))°C")
        iconImage.image = UIImage(named: "\(iconHourly)")
        
        // Condition requested in exercise
        if Int(humidity * 100) > 0 {
            humidityLabel.text = String("\(Int(humidity * 100))%")
        } else {
            humidityLabel.text = ""
        }
        
    }
}
