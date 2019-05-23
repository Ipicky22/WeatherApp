//
//  HourlyTableViewCell.swift
//  WeatherApp
//
//  Created by Adrien Masson on 22/05/2019.
//  Copyright © 2019 Adrien. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    func configure(time: Int, temperature: Double, humidity: Double, iconHourly: String) {
        timeLabel.text = String(time)
        temperatureLabel.text = String(temperature)
        humidityLabel.text = String(humidity)
        iconImage.image = UIImage(named: "\(iconHourly)")
    }
}
