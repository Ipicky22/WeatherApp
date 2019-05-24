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
        
        let date = NSDate(timeIntervalSince1970: time)
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("HH")
        formatter.timeZone = TimeZone(identifier: timezone)
        timeLabel.text = "\(formatter.string(from: date as Date))"
        
        temperatureLabel.text = String("\(Int(temperature))°C")
        if Int(humidity * 100) > 0 {
          humidityLabel.text = String("\(Int(humidity * 100))%")
        } else {
            humidityLabel.text = ""
        }
        iconImage.image = UIImage(named: "\(iconHourly)")
    }
}
