//
//  ExtraFirstTableViewCell.swift
//  WeatherApp
//
//  Created by Efreitech on 22/05/2019.
//  Copyright © 2019 Adrien. All rights reserved.
//

import UIKit

class ExtraFirstTableViewCell: UITableViewCell {

    
    @IBOutlet weak var humidityTitleLabel: UILabel!
    @IBOutlet weak var windSpeedTitleLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    func configure(humidity: Double, windSpeed: Double) {
        
        humidityTitleLabel.text = "Humidity"
        windSpeedTitleLabel.text = "Wind Speed"
        
        humidityLabel.text = String(humidity)
        windSpeedLabel.text = String(windSpeed)
    }
    
}
