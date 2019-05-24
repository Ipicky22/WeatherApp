//
//  ForecastTextTableViewCell.swift
//  WeatherApp
//
//  Created by Adrien & Maxime Masson on 22/05/2019.
//  Copyright © 2019 Adrien & Maxime. All rights reserved.
//

import UIKit

class ForecastTextTableViewCell: UITableViewCell {

    @IBOutlet weak var summaryLabel: UILabel!
    
    func configure(summary: String) {
        summaryLabel.text = summary
    }
}
