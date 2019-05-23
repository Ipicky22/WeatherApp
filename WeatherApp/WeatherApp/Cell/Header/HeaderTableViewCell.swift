//
//  HeaderTableViewCell.swift
//  WeatherApp
//
//  Created by Adrien Masson on 22/05/2019.
//  Copyright © 2019 Adrien. All rights reserved.
//

import UIKit
import SDWebImage

class HeaderTableViewCell: UITableViewCell {

    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    
    func configure(temperature: Double, summary: String, iconHeader: String){
        temperatureLabel.text = String(temperature)
        summaryLabel.text = summary
        iconImage.image = UIImage(named: "\(iconHeader).png")
    }
}
