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
    
    func configure(day: Int, temperatureHigh: Double, temperatureLow: Double, iconDaily: String ) {
        dayLabel.text = String(day)
        temperatureHighLabel.text = String(temperatureHigh)
        temperatureLowLabel.text = String(temperatureLow)
        iconImage.image = UIImage(named: "\(iconDaily)")
    }
}
