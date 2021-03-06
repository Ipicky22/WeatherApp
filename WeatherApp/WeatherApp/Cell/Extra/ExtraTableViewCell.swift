//
//  ExtraTableViewCell.swift
//  WeatherApp
//
//  Created by Adrien & Maxime Masson on 22/05/2019.
//  Copyright © 2019 Adrien & Maxime. All rights reserved.
//

import UIKit

class ExtraTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var pressureTitleLabel: UILabel!
    @IBOutlet weak var uvIndexTitleLabel: UILabel!
    
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var uvIndexLabel: UILabel!
    
    func configure(pressure: Double, uvIndex: Int) {
        
        pressureTitleLabel.text = "Pressure"
        uvIndexTitleLabel.text = "UV Index"
        
        pressureLabel.text = String("\(Int(pressure)) hPa")
        uvIndexLabel.text = String(uvIndex)
        
    }
}
