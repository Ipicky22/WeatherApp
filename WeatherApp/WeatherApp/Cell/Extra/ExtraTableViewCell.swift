//
//  ExtraTableViewCell.swift
//  WeatherApp
//
//  Created by Adrien Masson on 22/05/2019.
//  Copyright © 2019 Adrien. All rights reserved.
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
        
        pressureLabel.text = String(pressure)
        uvIndexLabel.text = String(uvIndex)
        
    }
}
