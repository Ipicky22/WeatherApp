//
//  DailyTableViewCell.swift
//  WeatherApp
//
//  Created by Adrien Masson on 22/05/2019.
//  Copyright © 2019 Adrien. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {


    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var temperatureHighLabel: UILabel!
    @IBOutlet weak var temperatureLowLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    func configure(day: Double, temperatureHigh: Double, temperatureLow: Double, iconDaily: String ) {
        let date = NSDate(timeIntervalSince1970: day)
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEE")
        dayLabel.text = "\(formatter.string(from: date as Date))"
        temperatureHighLabel.text = String("\(Int(temperatureLow))°C")
        temperatureLowLabel.text = String("\(Int(temperatureHigh))°C")
        iconImage.image = UIImage(named: "\(iconDaily)")
    }
}
