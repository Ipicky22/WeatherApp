//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Adrien & Maxime Masson on 22/05/2019.
//  Copyright © 2019 Adrien & Maxime. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {


    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureHighLabel: UILabel!
    @IBOutlet weak var temperatureLowLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    func configure(day: Double, temperatureHigh: Double, temperatureLow: Double, iconDaily: String ) {
        
        // CONVERSION
        // Returns a date object initialized relative to 00:00:00 UTC on 1 January 1970 by a given number of seconds
        let date = NSDate(timeIntervalSince1970: day)
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEE")
        
        // VALUES
        dayLabel.text = "\(formatter.string(from: date as Date))"
        temperatureHighLabel.text = String("\(Int(temperatureLow))°C")
        temperatureLowLabel.text = String("\(Int(temperatureHigh))°C")
        iconImage.image = UIImage(named: "\(iconDaily)")
        
    }
}
